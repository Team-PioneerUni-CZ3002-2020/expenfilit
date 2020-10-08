import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Expenfilit/Model/user.dart';

class AuthController {
  final String userUid;

  AuthController({this.userUid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String accName, String email, String uid) async {
    return await userCollection.doc(uid).set({
      'uid': userUid,
      'accName': accName,
      'email': email,
      'points': 0,
    });
  }

  SessionUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return SessionUser(
          uid: userUid,
          accName: snapshot.data()['accName'],
          email: snapshot.data()['email']
          // points: snapshot.data()['points']
          );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<SessionUser> get userData {
    return userCollection.doc(userUid).snapshots().map(_userDataFromSnapshot);
  }
}
