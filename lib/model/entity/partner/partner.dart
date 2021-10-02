import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/firestore/converter/nullable_timestamp_converter.dart';
import '../../../services/firestore/converter/timestamp_converter.dart';
import '../../../services/firestore/key/created_at_key.dart';
import '../../../services/firestore/key/updated_at_key.dart';
import '../../enums/request_status.dart';
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
    String? submitRequestUser,
    String? receiveRequestUser,
    RequestStatus? requestStatus,
    @anniversaryKey DateTime? anniversary,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _Partner;

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}
