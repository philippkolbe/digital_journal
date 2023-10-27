import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/models/summary.dart';

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
    SummaryObj? summary,
  }) = SimpleJournalEntryObj;

  const factory JournalEntryObj.chat({
    String? id,
    required String name,
    @DateConverter() required DateTime date,
    String? goal, 
    SummaryObj? summary,
    String? personalityId,
  }) = ChatJournalEntryObj;

  factory JournalEntryObj.fromJson(Map<String,dynamic> json) => _$JournalEntryObjFromJson(json);

  factory JournalEntryObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();

    assert(data != null, "Document has to exist to create a JournalEntryObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    data['runtimeType'] = data['type'];
    if (data.containsKey('summaryContent') && data['summaryContent'] != null) {
      data['summary'] = {
        'content': data['summaryContent'],
        'date': data['summaryDate'],
        'validUpToId': data['summaryValidUpToId'],
      };
    }
    return JournalEntryObj.fromJson(data);
  }

  // TODO: If we just named this runtimeType these conversions would be easier...
  Map<String, dynamic> toDocument() {
    final json = toJson();
    json['type'] = json['runtimeType'];

    final summaryJson = summary?.toJournalEntryJson();

    return json
      ..remove('summary')
      ..remove('id')
      ..remove('runtimeType')
      ..addAll(summaryJson ?? {});
  }
}