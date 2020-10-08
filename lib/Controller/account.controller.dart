import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/account.dart';
import '../View/accounts/component_acc_cat.dart';

class AccountController extends GetxController {
  static AccountController accCtrl = Get.find();

  final acc =
      Account(name: '', type: "Cash Wallet", balance: 0, isAssetSum: false).obs;

  // RxList<Account> accounts = <Account>[].obs;
  RxBool isNegBalance = false.obs;
  RxBool isAddingAcc = false.obs;

  toggleNegBal() => isNegBalance.toggle();
  updateAccName(String name) => acc.update((value) => value.name = name);
  updateAccType(String type) => acc.update((value) => value.type = type);
  // updateIsAssetSum(bool isAssetSum) => acc.update((value) => value.isAssetSum = isAssetSum);
  toggleAsset(bool v) => acc.update((value) => value.isAssetSum = v);
  updateAccBal(double bal) => acc.update(
        (value) => value.balance = bal * (isNegBalance.value == true ? -1 : 1),
      );

  List<Widget> getAccountCategories(List<Account> accs) {
    try {
      List<Widget> cats = [];
      for (var t in [
        "Bank Account",
        "Credit Card",
        "Investments",
        "Loans",
        "Cash Wallet",
        "Insurance"
      ]) {
        // print(accounts.where((acc) => acc.type == t).toList()[0].type);
        if (accs != null && accs.length > 0) {
          List<Account> accList = accs.where((acc) => acc.type == t).toList();
          if (accList != null && accList.length > 0) {
            cats.add(AccountCategory(accounts: accList));
          } else
            cats.add(Opacity(opacity: 0));
        }

        if (accs == null || cats.length < 1) {
          cats.add(
            Center(
              child: Text('Looking empty. Add new accounts?'),
            ),
          );
        }
      }
      return cats;
    } catch (e) {
      print(e.toString());
      return [Opacity(opacity: 0)];
    }
  }
}
