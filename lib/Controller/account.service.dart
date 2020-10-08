import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/account.dart';

class AccountService {
  final CollectionReference accountsRef =
      FirebaseFirestore.instance.collection('accounts');

  final String userUid;

  AccountService(this.userUid);

  Stream<List<Account>> get accounts {
    try {
      return accountsRef
          .where("userUid", isEqualTo: userUid)
          .get()
          .then((value) {
        return value.docs.map((e) => Account.fromSnapshot(e)).toList();
      }).asStream();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addOne(String userUid, Account acc) async {
    var result = await accountsRef.add({
      // 'accUuid': accountsRef.id,
      'accName': acc.name,
      'accType': acc.type,
      'balance': acc.balance,
      'isAssetSum': acc.isAssetSum,
      'userUid': userUid,
      'createdOn': new DateTime.now().toIso8601String(),
    });
    return result;
  }

  Future updateUserAccData(String accUuid, String name, String type,
      double balance, String userUid) async {
    return await accountsRef.doc(accUuid).set({
      'accUuid': accUuid,
      'accName': name,
      'accType': type == null ? "Wallet" : type,
      'balance': balance == null ? 0.0 : balance,
      'userUid': userUid,
      'createdOn': new DateTime.now().toIso8601String(),
    });
  }
}
