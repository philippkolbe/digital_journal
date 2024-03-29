import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary.freezed.dart';
part 'summary.g.dart';

@freezed
class SummaryObj with _$SummaryObj {
  const SummaryObj._();

  const factory SummaryObj({
    @DateConverter() required DateTime date,
    String? validUpToId,
    @Default("") String content,
  }) = _SummaryObj;

  factory SummaryObj.fromJson(Map<String, dynamic> json) => _$SummaryObjFromJson(json);

  Map<String, dynamic> toJournalEntryJson() {
    final json = toJson();
    return {
      'summaryContent': json['content'],
      'summaryDate': json['date'],
      'summaryValidUpToId': json['validUpToId'], 
    };
  }
}
