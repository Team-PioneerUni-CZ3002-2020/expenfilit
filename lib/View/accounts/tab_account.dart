import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:Expenfilit/Model/account.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:Expenfilit/View/components/loading.dart';
import 'package:Expenfilit/View/accounts/component_acc_cat.dart';
import 'package:Expenfilit/View/components/colours.dart';

class AccountsTab extends StatelessWidget {
  const AccountsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);

    List<Account> accounts = [
      Account(name: "POSB", type: "Bank Account", balance: 0, currency: "SGD"),
      Account(name: "StanChart", type: "Bank Account", balance: 311.92),
      Account(name: "iPad Pro 256GB", type: "Credit Card", balance: -708.75),
      Account(name: "Maybank", type: "Credit Card", balance: 0.02),
      Account(name: "Singlife", type: "Investments", balance: 10859.79),
      Account(name: "StashAway", type: "Investments", balance: 499.87),
      Account(name: "iPad Pro 256GB", type: "Loans", balance: -708.75),
      Account(name: "Maybank", type: "Loans", balance: 0.02),
      Account(name: "Wallet", type: "Cash Wallet", balance: 0.00),
      Account(name: "Grabfood Voucher", type: "Cash Wallet", balance: 10.0),
    ];

    String assetSum = new NumberFormat.simpleCurrency()
        .format(accounts.map((a) => a.balance).fold(0.0, (p, c) => p + c));

    const List<String> types = [
      "Bank Account",
      "Credit Card",
      "Investments",
      "Loans",
      "Cash Wallet"
    ];

    List<Widget> getAccountCategories(List<String> types) {
      List<AccountCategory> cats = [];
      for (var t in types) {
        // print(accounts.where((acc) => acc.type == t).toList()[0].type);
        cats.add(AccountCategory(
            accounts: accounts.where((acc) => acc.type == t).toList()));
      }
      return cats;
    }

    return user == null
        ? Loading()
        : Scaffold(
            backgroundColor: themeGreyWhite,
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      BluePatternHeader(assetSum: assetSum),
                      // AccountCategory(acc: accounts[0]),
                      ...getAccountCategories(types),
                      // -------- vvv BOTTOM | ADD ACCOUNT BTN vvv -------- //
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 35, horizontal: 20),
                          child: FlatButton(
                            child: Text(
                              'Add Account',
                              style: TextStyle(
                                color: themeDarkerBlack,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: themeDarkerBlack, width: 3)),
                            onPressed: () {
                              Navigator.pushNamed(context, "/addAccount");
                            },
                          ),
                        ),
                      )
                      // -------- ^^^ BOTTOM | ADD ACCOUNT BTN ^^^ -------- //
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
