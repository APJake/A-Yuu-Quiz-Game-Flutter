import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirestore {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future played(int points) async {
    await users.doc(_currentUser?.uid).update({
      "points": FieldValue.increment(points),
      "played": FieldValue.increment(1)
    });
  }
}
