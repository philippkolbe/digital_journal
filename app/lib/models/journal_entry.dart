import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

enum JournalEntryType {
  simple,
  chat,
}

@freezed
class JournalEntryObj with _$JournalEntryObj {
  const JournalEntryObj._();

  const factory JournalEntryObj.simple({
    String? id,
    required String name,
    @DateConverter() required DateTime date,
    @Default("") String? content,
  }) = SimpleJournalEntryObj;

  const factory JournalEntryObj.chat({
    String? id,
    required String name,
    @DateConverter() required DateTime date,
    String? goal, 
  }) = ChatJournalEntryObj;

  factory JournalEntryObj.fromJson(Map<String,dynamic> json) => _$JournalEntryObjFromJson(json);

  factory JournalEntryObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final typeString = data['type'];
    final type = JournalEntryType.values.firstWhere(
      (entryType) => entryType.name == typeString,
      orElse: () => throw Exception('Invalid journal entry type $typeString.'),
    );

    const dateConverter = DateConverter();

    switch (type) {
      case JournalEntryType.simple:
        return JournalEntryObj.simple(
          id: doc.id,
          name: data['name'] as String,
          date: dateConverter.fromJson(data['date'] as Timestamp),
          content: data['content'],
        );
      case JournalEntryType.chat:
        return JournalEntryObj.chat(
          id: doc.id,
          name: data['name'] as String,
          date: dateConverter.fromJson(data['date'] as Timestamp),
          goal: data['goal'],
        );
      default:
        throw Exception('Invalid journal entry type');
    }
  }

  Map<String, dynamic> toDocument() {
    final json = toJson()
      ..remove('id');

    if (this is SimpleJournalEntryObj) {
      return json
        ..addEntries([MapEntry('type', JournalEntryType.simple.name)]);
    } else if (this is ChatJournalEntryObj) {
      return json
        ..addEntries([MapEntry('type', JournalEntryType.chat.name)]);
    } else {
      throw Exception('Invalid journal entry type');
    }
  }
}