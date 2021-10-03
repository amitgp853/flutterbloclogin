import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserRepository({required this.firebaseAuth});

  Future<User?> signUp(String email, String password) async {
    try {
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString);
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    return await firebaseAuth.currentUser;
  }
}
