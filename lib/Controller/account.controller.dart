import 'package:Expenfilit/Controller/account.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/account.dart';
import '../View/accounts/component_acc_cat.dart';

class AccountController extends GetxController {
  static AccountController accCtrl = Get.find();
  AccountController({this.userUid});
  AccountService _accSrvc;
  final String userUid;

  //
  TextEditingController accNameField;
  TextEditingController accBalanceField;

  var acc =
      Account(name: '', type: "Cash Wallet", balance: 0, isAssetSum: false).obs;

  RxList accounts = [].obs;
  RxBool isNegBalance = false.obs;
  RxBool isAddingAcc = false.obs;

  toggleNegBal() => isNegBalance.toggle();
  updateAccName(String name) => acc.update((value) => value.name = name);
  updateAccType(String type) => acc.update((value) => value.type = type);
  // updateIsAssetSum(bool isAssetSum) => acc.update((value) => value.isAssetSum = isAssetSum);
  toggleAsset(bool v) => acc.update((value) => value.isAssetSum = v);
  void updateAccBal(double bal) => acc.update(
        (value) => value.balance = bal * (isNegBalance.value == true ? -1 : 1),
      );

  onInit() {
    accNameField = TextEditingController();
    accBalanceField = TextEditingController();
    _accSrvc = AccountService(userUid);
    accounts.bindStream(_accSrvc.accounts);
  }

  List<Widget> getAccountCategories(List<Account> accs) {
    try {
      int uiIdx = 0;
      List<Widget> cats = [];
      for (var t in [
        "Bank Account",
        "Cash Wallet",
        "Credit Card",
        "Insurance",
        "Investments",
        "Loans",
      ]) {
        // print(accounts.where((acc) => acc.type == t).toList()[0].type);
        if (accs != null && accs.length > 0) {
          List<int> uiIdxes = [];
          List<Account> accList = accs.where((acc) => acc.type == t).toList();
          accList.forEach((a) => uiIdxes.add(uiIdx++));
          if (accList != null && accList.length > 0) {
            cats.add(AccountCategory(accounts: accList, accIdx: uiIdxes));
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

  refreshAccount() {
    acc.value = Account.fromJson(Account(
      accUuid: '',
      name: '',
      type: "Cash Wallet",
      balance: 0,
      isAssetSum: true,
      createdOn: DateTime.now(),
    ).toJson());
    accNameField.clear();
    accBalanceField.clear();
    isNegBalance.value = false;
  }

  addAccount() async {
    try {
      // isAddingTodo.value = true;
      updateAccName(accNameField.text);
      updateAccBal(double.parse(accBalanceField.text));
      var newAcc = await _accSrvc.addOne(acc());
      accounts.add(newAcc);
      Get.snackbar("Success", newAcc.name, snackPosition: SnackPosition.TOP);
      refreshAccount();
      // isAddingTodo.value = false;
    } catch (e) {
      // isAddingTodo.value = false;
      print(e);
    }
  }

  manAccount(String manageType) async {
    try {
      // isAddingTodo.value = true;
      updateAccName(accNameField.text);
      updateAccBal(double.parse(accBalanceField.text.replaceAll(",", "")));

      if (manageType == "edit") {
        await _accSrvc.updateOne(acc());
        int index =
            accounts.indexWhere((element) => element.accUuid == acc().accUuid);

        accounts[index] = acc.value;
      } else {
        //add
        var newAcc = await _accSrvc.addOne(acc());
        accounts.add(newAcc);
        Get.snackbar("Success", newAcc.name, snackPosition: SnackPosition.TOP);
      }

      Get.snackbar("Success", accNameField.text,
          snackPosition: SnackPosition.TOP);
      refreshAccount();
      // isAddingTodo.value = false;
    } catch (e) {
      // isAddingTodo.value = false;
      print(e);
    }
  }

  deleteAccount(String id) async {
    try {
      await _accSrvc.deleteOne(id);
      int index = accounts.indexWhere((a) => a.accUuid == id);
      accounts.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.TOP);
      refreshAccount();
    } catch (e) {
      print(e);
    }
  }

  @override
  onClose() {
    accNameField?.dispose();
    accBalanceField?.dispose();
  }
}
