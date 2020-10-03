import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/Model/account.dart';

class DatabaseController {
  final String userUid;

  DatabaseController({this.userUid});

  //collection reference
  final CollectionReference accountCollection =
      FirebaseFirestore.instance.collection('accounts');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String displayName, String email, String uid) async {
    return await userCollection.doc(uid).set({
      'uid': userUid,
      'displayName': displayName,
      'email': email,
      'points': 0,
    });
  }

  Future updateUserTxnData(String accUuid, String accName, String accType,
      double balance, String userUid) async {
    return await accountCollection.doc(accUuid).set({
      'accUuid': accUuid,
      'accName': accName,
      'accType': accType == null ? "Wallet" : accType,
      'balance': balance == null ? 0.0 : balance,
      'userUid': userUid,
    });
  }

  List<Account> _accListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Account(
        accName: doc.data()['accName'] ?? '',
        accType: doc.data()['accType'] ?? 'Wallet',
        balance: doc.data()['balance'] ?? 0,
      );
    }).toList();
  }

  //userData from snapshot
  SessionUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return SessionUser(
        uid: userUid,
        displayName: snapshot.data()['displayName'],
        email: snapshot.data()['email']
        // points: snapshot.data()['points']
        );
  }

  // get user doc stream
  Stream<SessionUser> get userData {
    return userCollection.doc(userUid).snapshots().map(_userDataFromSnapshot);
  }

  // get brews stream
  Stream<List<Account>> get accounts {
    return accountCollection.snapshots().map(_accListFromSnapshot);
  }
}
