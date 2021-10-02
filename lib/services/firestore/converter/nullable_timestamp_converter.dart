import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class NullableTimestampConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => timestampFromJson(json);

  @override
  Timestamp? toJson(DateTime? object) => timestampToJson(object);

  static DateTime? timestampFromJson(Timestamp? json) => json?.toDate();

  static Timestamp? timestampToJson(DateTime? object) =>
      object != null ? Timestamp.fromDate(object) : null;
}
