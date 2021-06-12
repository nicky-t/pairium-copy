import 'package:json_annotation/json_annotation.dart';

import '../converter/timestamp_converter.dart';
import '../firestore_field.dart';

const updatedAtKey = JsonKey(
  name: FirestoreField.updatedAt,
  fromJson: TimestampConverter.timestampFromJson,
  toJson: TimestampConverter.timestampToJson,
);
