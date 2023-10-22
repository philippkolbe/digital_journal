import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/attribute.dart';
import 'package:app/models/attributes_action.dart';
import 'package:app/repositories/attribute_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attributesProvider = StateNotifierProvider<AttributesController, AsyncValue<AttributesState>>((ref) {
  final attributeRepository = ref.watch(attributeRepositoryProvider);
  final userId = ref.watch(userIdProvider);

  return AttributesController(attributeRepository, userId)..init();
});

class AttributesState {
  final List<AttributeObj> attributes;
  late final Map<AttributeType, List<AttributeObj>> groupedByType; 

  AttributesState({
    required this.attributes, Map<AttributeType,
    List<AttributeObj>>? groupedByType
  }) {
    if (groupedByType != null) {
      this.groupedByType = groupedByType;
    } else {
      this.groupedByType = Map.fromEntries(
        AttributeType.values.map((type) => MapEntry(type, []))
      );

      for (final attribute in attributes) {
        this.groupedByType[attribute.type]!.add(attribute);
      }
    }
  }

  AttributesState copyWithAttributeAdded(AttributeObj attribute) {
    return AttributesState(
      attributes: [...attributes, attribute],
      groupedByType: {
        ...groupedByType,
        attribute.type: [...groupedByType[attribute.type]!, attribute],
      },
    );
  }

  AttributesState copyWithAttributeUpdated(AttributeObj updatedAttribute) {
    return AttributesState(
      attributes: attributes.map((attr) => attr.id == updatedAttribute.id ? updatedAttribute : attr).toList(),
      groupedByType: {
        ...groupedByType,
        updatedAttribute.type: groupedByType[updatedAttribute.type]!.map((attr) => attr.id == updatedAttribute.id ? updatedAttribute : attr).toList(),
      },
    );
  }

  AttributesState copyWithAttributeDeleted(String attributeId) {
    final attribute = attributes.firstWhere((attr) => attr.id == attributeId);
    return AttributesState(
      attributes: attributes..remove(attribute),
      groupedByType: {
        ...groupedByType,
        attribute.type: groupedByType[attribute.type]!..remove(attribute),
      },
    );
  }
}

class AttributesController extends StateNotifier<AsyncValue<AttributesState>> {
  final BaseAttributeRepository _attributesRepository;
  final String? _userId;

  final Map<AttributeType, int> _countsByType = {};
  final Map<String, String> _idToCountingIdMap = {};
  final Map<String, String> _countingIdToIdMap = {};

  AttributesController(this._attributesRepository, this._userId) : super(const AsyncLoading()) {
    for (final type in AttributeType.values) {
      _countsByType[type] = 0;
    }
  }

  Future<void> init() async {
    if (_userId != null) {
      await loadAttributes();
    }
  }

  Future<void> loadAttributes() async {
    try {
      if (state is! AsyncLoading) {
        state = const AsyncLoading();
      }

      final attributes = await _attributesRepository.readAllAttributes(_userId!);
      final withCountingIds = attributes.map(_addCountingId).toList();
      state = AsyncData(AttributesState(attributes: withCountingIds));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// The ids in attributes actions are assumed to be countingIds!
  Future<void> applyAttributesActions(List<AttributesActionObj> attributesActions) async {
    if (attributesActions.isEmpty) {
      return;
    }

    try {
      assert(state is AsyncData, "Attributes must be loaded to apply attributes actions.");
      final withIds = attributesActions
        .map(_convertCountingIdInAction)
        .whereType<AttributesActionObj>()
        .toList();
      final attributesAfterUpdates = await _attributesRepository.applyAttributesActions(_userId!, withIds);
      state = AsyncData(AttributesState(attributes: attributesAfterUpdates.map((attribute) => attribute.copyWith(
        countingId: _getCountingId(attribute)
      )).toList()));
    } catch (error) {
      // TODO: handle this error. E.g. if some inputted id did not exist the request will fail.
      print("Error while applying attributes Actions ${attributesActions.toString()}: ${error.toString()}");
      // state = AsyncError(error, stackTrace);
    }
  }

  Future<void> addAttribute(AttributeObj attribute) async {
    try {
      assert(state is AsyncData, "Attributes must be loaded to add a new attribute.");
      
      final withoutCountingId = attribute.copyWith(
        countingId: null, // we set the countingId to null so that its correctness is ensured by this controller
      );
      final newAttributeId = await _attributesRepository.createAttribute(_userId!, withoutCountingId);
      state = AsyncData(
        state.value!.copyWithAttributeAdded(attribute.copyWith(
          id: newAttributeId,
          countingId: _getCountingId(attribute),
        )),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateAttribute(AttributeObj updatedAttribute) async {
    try {
      assert(state is AsyncData, "Attributes must be loaded to update attributes.");
      final withCorrectCountingId = updatedAttribute.copyWith(
        countingId: _getCountingId(updatedAttribute), // we set the countingId to our own so that its correctness is ensured by this controller
      );
      await _attributesRepository.updateAttribute(_userId!, withCorrectCountingId);
      state = AsyncData(state.value!.copyWithAttributeUpdated(withCorrectCountingId));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteAttribute(String attributeId) async {
    try {
      assert(state is AsyncData, "Attributes must be loaded to delete attributes.");
      await _attributesRepository.deleteAttribute(_userId!, attributeId);
      state = AsyncData(state.value!.copyWithAttributeDeleted(attributeId));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  AttributeObj _addCountingId(AttributeObj attributeObj) {
    return attributeObj.copyWith(
      countingId: _getCountingId(attributeObj)
    );
  }

  String _getCountingId(AttributeObj attributeObj) {
    final id = attributeObj.id;
    if (_idToCountingIdMap.containsKey(id)) {
      return _idToCountingIdMap[id]!;
    } else {
      final attributeType = attributeObj.type;
      final count = _countsByType[attributeObj.type]!;

      _countsByType[attributeObj.type] = count + 1;

      final countingId = '${attributeType.name}$count';

      if (id != null) {
        _idToCountingIdMap[id] = countingId;
        _countingIdToIdMap[countingId] = id;
      }

      return countingId;
    }
  }

  AttributesActionObj? _convertCountingIdInAction(AttributesActionObj action) {
    return action.map(
      create: (create) => AttributesActionObj.create(
        type: create.type,
        description: create.description,
        level: create.level
      ),
      update: (update) {
        final id = _validateId(update.id);
        return id != null
          ? AttributesActionObj.update(
            id: id,
            description: update.description,
            level: update.level,
          ) : null;
      },
      delete: (delete) {
        final id = _validateId(delete.id);
        return id != null
          ? AttributesActionObj.delete(
            id: id
          ) : null;
      },
    );
  }

  String? _validateId(String id) {
    if (_countingIdToIdMap.containsKey(id)) {
      return _countingIdToIdMap[id];
    } else if (_idToCountingIdMap.containsKey(id)) {
      return _idToCountingIdMap[id];
    } else {
      return null;
    }
  }
}