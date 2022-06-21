import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentification {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        User? user = userCredential.user;
        // create in firestore
        if (user != null) {
          var snapshot = await users.doc(user.uid).get();
          if (!snapshot.exists) {
            await snapshot.reference.set({"points": 0, "played": 0});
          }
          return user;
        }
        return;
      }
    } else {
      throw FirebaseAuthException(
          code: "ERROR_ABORDED_BY_USER", message: "Sign in is aborded by user");
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
