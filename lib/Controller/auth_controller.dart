import 'package:Expenfilit/Controller/database_controller.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  SessionUser _userFromFirebaseUser(User user) {
    return user != null
        ? SessionUser(
            uid: user.uid, email: user.email, displayName: user.displayName)
        : null;
  }

  ///User login ; will only be granted after user verify their email address.
  Future signinEmail(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///Forget Password; Allow user to reset their password with the link send to their email address.
  Future sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((error) => print(error.code));
  }

  ///To create a new account with a valid email address.
  Future signupEmailPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authResult != null) {
        //FirebaseUser firebaseUser = authResult.user;
        User firebaseUser = authResult.user;

        if (firebaseUser != null) {
          await firebaseUser.reload();

          print("Sign up: $firebaseUser");

          await firebaseUser.sendEmailVerification();
          // create a new document for the user with the uid

          final dbController = DatabaseController(userUid: firebaseUser.uid);
          await dbController.updateUserData(
              displayName, email, firebaseUser.uid);
          await dbController.updateUserTxnData(
              Uuid().v4(), "Default Account", null, null, firebaseUser.uid);
          return _userFromFirebaseUser(firebaseUser);
        }
      }
    } catch (e) {
      print("An error occured while trying to create new user!");
      print(e.toString());
      return null;
    }
  }

  /// User Log Out.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //auth change user stream
  Stream<SessionUser> get user {
    return _auth
        .authStateChanges() //onAuthStateChanged deprecated
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      //AuthResult class has been renamed to UserCredential.
      //AuthResult result = await _auth.signInAnonymously();
      UserCredential result = await _auth.signInAnonymously();
      //FirebaseUser class has been renamed to User.
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
