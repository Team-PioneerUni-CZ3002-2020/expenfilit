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

  set uuid(uid) => this.accUuid = uid;

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

  Account.fromJson(Map<String, dynamic> json)
      : accUuid = json['accUuid'],
        name = json['name'],
        type = json['type'],
        balance = json['balance'],
        isAssetSum = json['isAssetSum'],
        userUid = json['userUid'],
        createdOn = DateTime.parse(json['createdOn']);

  Map<String, dynamic> toJson() {
    try {
      return {
        "accUuid": accUuid,
        "name": name ?? "NO NAME",
        "type": type ?? "NO TYPE RECEIVED",
        "balance": balance ?? "NO BALANCE",
        "isAssetSum": isAssetSum ?? true,
        "userUid": userUid,
        "createdOn": createdOn.toString(),
      };
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
