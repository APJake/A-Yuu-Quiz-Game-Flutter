import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt totalPoints = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void listenUser() {
    print("get");
    firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .asBroadcastStream()
        .listen((DocumentSnapshot snapshot) {
      var data = snapshot.data();
      print("hello: $data");
    });
  }
}
