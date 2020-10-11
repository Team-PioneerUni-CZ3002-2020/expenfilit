import 'package:Expenfilit/Controller/account.controller.dart';
import 'package:Expenfilit/Controller/account.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:Expenfilit/Model/account.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:Expenfilit/View/components/loading.dart';
import 'package:Expenfilit/View/components/colours.dart';

class AccountsTab extends StatelessWidget {
  const AccountsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);
    final AccountController accCon = AccountController();

    // String assetSum = new NumberFormat.simpleCurrency()
    //     .format(accounts.map((a) => a.balance).fold(0.0, (p, c) => p + c));

    return user == null
        ? Loading()
        : StreamProvider<List<Account>>.value(
            value: AccountService(user.uid).accounts,
            updateShouldNotify: (_, __) => true,
            child: Scaffold(
              backgroundColor: themeGreyWhite,
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return false;
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    child: Consumer<List<Account>>(
                      builder: (context, accounts, child) {
                        return accounts == null
                            ? Loading()
                            : Column(
                                children: <Widget>[
                                  BluePatternHeader(
                                    assetSum: new NumberFormat.simpleCurrency()
                                        .format(accounts != null
                                            ? accounts
                                                .where((a) => a?.isAssetSum)
                                                .map((a) => a?.balance ?? 0)
                                                .fold(0.0, (p, c) => p + c)
                                            : 0.0),
                                  ),
                                  ...accCon.getAccountCategories(accounts),
                                  // -------- vvv BOTTOM | ADD ACCOUNT BTN vvv -------- //
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minWidth: double.infinity),
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
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: themeDarkerBlack,
                                                width: 3)),
                                        onPressed: () => Navigator.pushNamed(
                                            context, "/addAccount"),
                                      ),
                                    ),
                                  )
                                  // -------- ^^^ BOTTOM | ADD ACCOUNT BTN ^^^ -------- //
                                ],
                              );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
