import '../../../model/type/user_id.dart';
import '../../model/entity/partner/partner_document.dart';
import '../../model/enums/request_status.dart';

abstract class PartnerRepository {
  Future<List<PartnerDocument>> fetchPartnerDocsByMyId({
    required UserId uid,
  });

  Future<String> createPartnerDoc({
    required UserId uid,
    required UserId pairDocId,
  });

  Future<void> updatePartnerDoc({
    required PartnerDocument partnerDoc,
    DateTime? anniversary,
    UserId? submitRequestUser,
    UserId? receiveRequestUser,
    RequestStatus? requestStatus,
  });

  Future<void> deletePartnerDoc({
    required PartnerDocument partnerDoc,
  });
}
