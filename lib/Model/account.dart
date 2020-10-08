import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  // String accUuid, name, type, currency, userUid;
  String accUuid, name, type, userUid;
  double balance;
  bool isAssetSum;
  DateTime createdOn;

  Account({
    this.accUuid,
    this.name,
    this.type,
    // this.currency,
    this.balance,
    this.isAssetSum,
    this.userUid,
    this.createdOn,
  });

  factory Account.fromSnapshot(DocumentSnapshot snap) {
    try {
      return Account(
        accUuid: snap.id,
        name: snap.data()['accName'],
        type: snap.data()['accType'],
        balance: snap.data()['balance'],
        isAssetSum: snap.data()['isAssetSum'],
        userUid: snap.data()['userUid'],
        createdOn: DateTime.parse(snap.data()['createdOn']),
        // gallery: List<ImageModel>.from(
        //     snap.data['gallery'].map((e) => ImageModel.fromJson(e))),
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  toJson() {
    return {"name": name, "type": type, "balance": balance};
  }
}
