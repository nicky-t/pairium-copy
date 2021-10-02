import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentReferenceConverter {
  static DocumentReference<Map<String, dynamic>>? documentReferenceFromJson(
          DocumentReference<Map<String, dynamic>>? json) =>
      json;

  static DocumentReference<Map<String, dynamic>>? documentReferenceToJson(
          DocumentReference<Map<String, dynamic>>? object) =>
      object;
}
