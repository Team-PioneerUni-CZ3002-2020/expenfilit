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
          .orderBy('accType')
          .get()
          .then((value) {
        return value.docs.map((e) => Account.fromSnapshot(e)).toList();
      }).asStream();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Account> addOne(Account acc) async {
    var result = await accountsRef.add({
      // 'accUuid': accountsRef.id,
      'accName': acc.name,
      'accType': acc.type,
      'balance': acc.balance,
      'isAssetSum': acc.isAssetSum,
      'userUid': userUid,
      'createdOn': new DateTime.now().toIso8601String(),
    });
    acc.uuid = result.id;
    return acc;
  }

  Future updateOne(Account acc) async {
    accountsRef.doc(acc.accUuid).update(
        {'accName': acc.name, 'accType': acc.type, 'balance': acc.balance});
  }

  deleteOne(String id) {
    accountsRef.doc(id).delete();
  }
}
