import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentReferenceConverter {
  static DocumentReference documentReferenceFromJson(DocumentReference json) =>
      json;

  static DocumentReference documentReferenceToJson(DocumentReference object) =>
      object;
}
