import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference usernameCollection =
      FirebaseFirestore.instance.collection('users');

  Future<User?> firebaseSignInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> firebaseGoogleLogin() async {
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      if (googleAuth == null) return null;

      // Create a new credential
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      UserCredential user = await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);
      return user.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> fetchUsernameByUid(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await usernameCollection.doc(uid).get();
      return documentSnapshot.get('username');
    } catch (e) {
      return null;
    }
  }
}
