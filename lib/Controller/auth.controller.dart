import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Expenfilit/Model/user.dart';

import '../Model/user.dart';

class AuthController {
  String userUid;

  AuthController({this.userUid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<SessionUser> addOne(
      String username, String email, String userUid) async {
    await userCollection.doc(userUid).set({
      'uid': userUid,
      'username': username,
      'email': email,
      'points': 0,
    });

    return new SessionUser(
        uid: userUid, username: username, email: email, points: 0);
  }

  // Future updateUserData(String username, String email, String uid) async {
  //   return await userCollection.doc(uid).update({
  //     'uid': userUid,
  //     'username': username,
  //     'email': email,
  //     'points': 0,
  //   });
  // }

  SessionUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return SessionUser(
          uid: userUid,
          username: snapshot.data()['username'],
          email: snapshot.data()['email'],
          points: snapshot.data()['points']);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<SessionUser> get userData {
    // print(userUid);
    return userCollection.doc(userUid).snapshots().map(_userDataFromSnapshot);
  }
}
