import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocument<T> {
  DocumentReference<Map<String, dynamic>> get ref;
  T get entity;
  String get documentId => ref.id;
}
