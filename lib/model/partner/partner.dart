import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore/converter/nullable_timestamp_converter.dart';
import '../../firebase/firestore/converter/timestamp_converter.dart';
import '../../firebase/firestore/key/created_at_key.dart';
import '../../firebase/firestore/key/updated_at_key.dart';
import 'partner_field.dart';

part 'partner.freezed.dart';
part 'partner.g.dart';

const anniversaryKey = JsonKey(
  name: PartnerField.anniversary,
  fromJson: NullableTimestampConverter.timestampFromJson,
  toJson: NullableTimestampConverter.timestampToJson,
);

@freezed
class Partner with _$Partner {
  const factory Partner({
    required List<String> userIds,
    @anniversaryKey DateTime? anniversary,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _Partner;

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}
