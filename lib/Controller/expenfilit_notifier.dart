import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:expenfilit_v1/Controller/expenfilit_notifier.dart';
import 'package:expenfilit_v1/Controller/auth_notifier.dart';
import 'package:expenfilit_v1/Model/user.dart';

///User login ; will only be granted after user verify their email address.
login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      if(currentUser.isEmailVerified){
        print("Log In: $firebaseUser");
        authNotifier.setUser(firebaseUser);
      }
      else{
        print("notify user to verify account");
      }
    }

  }
}

///Forget Password; Allow user to reset their password with the link send to their email address.
Future sendPasswordResetEmail(User user) async {
  return FirebaseAuth.instance.sendPasswordResetEmail(email: user.email).catchError((error) => print(error.code));
}

///To create a new account with a valid email address.
signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.username;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

      try {
        currentUser.sendEmailVerification();
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }
      if(currentUser.isEmailVerified){

      }
    }
  }
}

/// User Log Out.
signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));
  authNotifier.setUser(null);
}

///Determine which state user is in, SignUp, Login or Reset
initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}