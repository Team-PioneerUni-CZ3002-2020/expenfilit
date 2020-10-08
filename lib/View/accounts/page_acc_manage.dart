import 'package:Expenfilit/Controller/account.controller.dart';
import 'package:Expenfilit/Controller/account.service.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/user.dart';

class ManageAccountPage extends StatelessWidget {
  ManageAccountPage({Key key, this.title}) : super(key: key);
  final title;

  final AccountController accCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);
    final AccountService accSrvc = Get.put(AccountService(user.uid));
    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Container(
          child: Column(children: <Widget>[
            Stack(children: <Widget>[
              ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: catColour(accCtrl.acc().type ?? "Cash Wallet"),
                      ),
                      padding: EdgeInsets.only(
                          top: 160, bottom: 45, left: 30, right: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            accCtrl.acc().type ?? 'Cash Wallet',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (text) => accCtrl.updateAccName(text),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              // helperText: 'Account name',
                              hintText: 'Account name',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(230, 236, 240, 0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              // focusColor: Color.fromRGBO(230, 236, 240, 0.5),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 236, 240, 0.5)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              WhiteTitleHeader(
                title: "New Account",
                // title: widget.title, //EDIT
                rightWidget: Container(
                  child: FlatButton(
                    minWidth: 0,
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      print("save pressed");
                      accSrvc.addOne(user.uid, accCtrl.acc());
                      Navigator.popAndPushNamed(context, '/');
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                          color: hghlgtBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                children: ListTile.divideTiles(context: context, tiles: [
                  Obx(
                    () => ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.edit, color: icUnselectGrey),
                          SizedBox(width: 10),
                          Text(
                            'Account Balance',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 10),
                          FlatButton(
                              onPressed: () => accCtrl.toggleNegBal(),
                              child: Text('+/-'),
                              minWidth: 5,
                              color: Color.fromRGBO(136, 153, 166, 0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                        ],
                      ),
                      trailing: Container(
                        width: 80,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${accCtrl.isNegBalance() ? '-' : ''} ",
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: TextField(
                                  onChanged: (text) =>
                                      accCtrl.updateAccBal(double.parse(text)),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: icUnselectGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: InputDecoration.collapsed(
                                    // contentPadding: EdgeInsets.all(0),
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                        color: icUnselectGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    // border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyTextInputFormatter()
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      tileColor: Colors.white,
                      onTap: () => {},
                    ),
                  ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Icon(Icons.credit_card, color: icUnselectGrey),
                  //       SizedBox(width: 10),
                  //       Text('Currency', style: TextStyle(fontSize: 14)),
                  //     ],
                  //   ),
                  //   trailing: Text(
                  //     "SGD",
                  //     style: TextStyle(
                  //         color: icUnselectGrey,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w700),
                  //   ),
                  //   tileColor: Colors.white,
                  // ),
                  ListTile(
                    onTap: () async {
                      // String accType = await Navigator.pushNamed(
                      //     context, "/addAccount/accType");
                      // Get.find<AccountController>().updateAccType(accType);
                      // widget.acc.type = await Navigator.pushNamed(
                      //     context, "/addAccount/accType");
                      Navigator.pushNamed(context, "/accounts/new/type");
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: icUnselectGrey,
                        ),
                        SizedBox(width: 10),
                        Obx(() => Text(
                            accCtrl.acc().type ?? 'Select Account Type',
                            style: TextStyle(fontSize: 14))),
                        // Text(widget.acc.getAccType ?? 'Select Account Type',
                        //     style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    tileColor: Colors.white,
                  ),
                  Obx(
                    () => Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Include in asset summary',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8899A6),
                                ),
                              ),
                              Transform.scale(
                                scale: 0.85,
                                child: CupertinoSwitch(
                                  value: accCtrl.acc().isAssetSum,
                                  onChanged: (v) => accCtrl.toggleAsset(v),
                                  // value: true,
                                  // onChanged: (v) => print("right. wont change"),
                                  activeColor: catColour(
                                      accCtrl.acc().type ?? "Cash Wallet"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 100),
                          // EDIT
                          // widget.title == "Edit Account"
                          //     ? FlatButton(
                          //         onPressed: null,
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: <Widget>[
                          //             Icon(
                          //               FlutterIcons.trash_2_fea,
                          //               size: 16,
                          //               color: hghlgtRed,
                          //             ),
                          //             SizedBox(width: 5),
                          //             Text(
                          //               'Delete Account',
                          //               style: TextStyle(
                          //                 decoration: TextDecoration.underline,
                          //                 color: hghlgtRed,
                          //                 fontWeight: FontWeight.w700,
                          //                 fontSize: 16,
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       )
                          //     : Opacity(opacity: 0)
                        ],
                      ),
                    ),
                  )
                ]).toList(),
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class AccountListPage extends StatelessWidget {
  AccountListPage({Key key}) : super(key: key);

  // final Destination destination;

  final AccountController accCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    const List<String> types = [
      "Bank Account",
      "Credit Card",
      "Cash Wallet",
      "Loans",
      "Investments",
      "Insurance"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Type", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: types.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              accCtrl.updateAccType(types[index]);
              print(accCtrl.acc().type);
              Navigator.pop(context);
            },
            title: Text(types[index]),
          );
        },
      ),
    );
  }
}
