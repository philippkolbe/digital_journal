import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/attribute.dart';
import 'package:app/models/attributes_action.dart';
import 'package:app/repositories/attribute_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attributesControllerProvider = StateNotifierProvider<AttributesController, AsyncValue<AttributesState>>((ref) {
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

  AttributesController(this._attributesRepository, this._userId) : super(const AsyncLoading());

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
      state = AsyncData(AttributesState(attributes: attributes));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> applyAttributesActions(List<AttributesActionObj> attributesActions) async {
    if (attributesActions.isEmpty) {
      return;
    }

    try {
      assert(state is AsyncData, "Attributes must be loaded to apply attributes actions.");
      final attributesAfterUpdates = await _attributesRepository.applyAttributesActions(_userId!, attributesActions);
      state = AsyncData(AttributesState(attributes: attributesAfterUpdates));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> addAttribute(AttributeObj attribute) async {
    try {
      assert(state is AsyncData, "Attributes must be loaded to add a new attribute.");
      final newAttributeId = await _attributesRepository.createAttribute(_userId!, attribute);
      state = AsyncData(
        state.value!.copyWithAttributeAdded(attribute.copyWith(id: newAttributeId))
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateAttribute(AttributeObj updatedAttribute) async {
    try {
      assert(state is AsyncData, "Attributes must be loaded to update attributes.");
      await _attributesRepository.updateAttribute(_userId!, updatedAttribute);
      state = AsyncData(state.value!.copyWithAttributeUpdated(updatedAttribute));
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
}