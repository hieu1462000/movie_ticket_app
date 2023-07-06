import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/models/auth_user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthUserModel? userFromFirebaseUser(User? user) {
    return user != null
        ? AuthUserModel(uid: user.uid, name: user.displayName)
        : null;
  }

  //auth change user stream
  Stream<AuthUserModel?> get user {
    return auth
        .authStateChanges()
        .map((User? user) => userFromFirebaseUser(user));
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      user?.updateDisplayName(name);
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
