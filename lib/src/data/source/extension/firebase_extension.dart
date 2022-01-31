import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseExtension on DocumentSnapshot {
  dynamic getSafety(String field) {
    try {
      return get(field);
    } on StateError catch (e) {
      return null;
    }
  }
}