import 'package:Expenfilit/Controller/account.controller.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/account.dart';
import '../../Model/user.dart';
import 'component_acc_cat.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);
    AccountController accCtrl = Get.put(AccountController(userUid: user.uid));
    const List<String> types = [
      "Bank Account",
      "Credit Card",
      "Cash Wallet",
      "Loans",
      "Investments",
      "Insurance"
    ];

    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Container(
          child: Column(children: <Widget>[
            // -------- vvv HEADER vvv -------- //
            WhiteTitleHeader(title: 'Add Account'),
            // -------- ^^^ HEADER ^^^ -------- //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'What account type are we adding?',
                style: TextStyle(
                  color: themeDarkerBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: types.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.85,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) => AccGridCard(
                    accCardType: types[index],
                    press: () {
                      // print('acctype pressed: ${types[index]}');
                      accCtrl.refreshAccount();
                      accCtrl.updateAccType(types[index]);
                      // Navigator.pushNamed(context, "/accounts/new");
                      Navigator.pushNamed(context, "/accounts/new",
                          arguments: new Account(type: types[index]));
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
