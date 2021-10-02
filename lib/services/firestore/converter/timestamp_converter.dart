import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => timestampFromJson(json);

  @override
  Timestamp toJson(DateTime object) => timestampToJson(object);

  static DateTime timestampFromJson(Timestamp json) => json.toDate();

  static Timestamp timestampToJson(DateTime object) =>
      Timestamp.fromDate(object);
}
