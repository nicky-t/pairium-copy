import 'package:json_annotation/json_annotation.dart';

import '../converter/timestamp_converter.dart';
import '../firestore_field.dart';

const createdAtKey = JsonKey(
  name: FirestoreField.createdAt,
  fromJson: TimestampConverter.timestampFromJson,
  toJson: TimestampConverter.timestampToJson,
);
