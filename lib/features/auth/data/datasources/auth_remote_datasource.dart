import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signIn();
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImpl({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<UserModel> signIn() async {
    User? user;
    try {
      if (firebaseAuth.currentUser == null) {
        final account = await googleSignIn.signIn();
        final auth = await account?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken,
          idToken: auth?.idToken,
        );

        final userCredential = await firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;
      } else {
        user = firebaseAuth.currentUser;
      }

      return UserModel.fromJson({'name': user?.displayName, 'email': user?.email});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      Exception(e);
    }
  }
}
