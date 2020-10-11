import 'package:Expenfilit/Controller/account.controller.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Expenfilit/View/components/colours.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/account.dart';
import '../../Model/user.dart';

class AccountsDetailsPage extends StatelessWidget {
  AccountsDetailsPage({Key key}) : super(key: key);

  SwiperController controller = new SwiperController();

  List<bool> autoplayes = new List()
    ..length = 10
    ..fillRange(0, 10, false);

  List<SwiperController> controllers = new List()
    ..length = 10
    ..fillRange(0, 10, new SwiperController());
  @override
  Widget build(BuildContext context) {
    // List<Account> accountsTest = [
    //   // Account(name: "POSB", type: "Bank Account", balance: 0, currency: "SGD"),
    //   Account(name: "POSB", type: "Bank Account", balance: 0),
    //   Account(name: "StanChart", type: "Bank Account", balance: 311.92),
    //   Account(name: "iPad Pro 256GB", type: "Credit Card", balance: -708.75),
    //   Account(name: "Maybank", type: "Credit Card", balance: 0.02),
    //   Account(name: "Singlife", type: "Investments", balance: 10859.79),
    //   Account(name: "StashAway", type: "Investments", balance: 499.87),
    //   Account(name: "iPad Pro 256GB", type: "Loans", balance: -708.75),
    //   Account(name: "Maybank", type: "Loans", balance: 0.02),
    //   Account(name: "Wallet", type: "Cash Wallet", balance: 0.00),
    //   Account(name: "Grabfood Voucher", type: "Cash Wallet", balance: 10.0),
    // ];
    final user = Provider.of<SessionUser>(context);
    AccountController accCtrl = Get.put(AccountController(userUid: user.uid));
    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            Stack(children: [
              Obx(
                () => SizedBox(
                  height: (MediaQuery.of(context).size.height / 10) * 3.4,
                  child: new Swiper(
                    loop: false,
                    itemCount: accCtrl.accounts.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return CardAccount(accCtrl.accounts.elementAt(index));
                    },
                  ),
                ),
              ),
              WhiteTitleHeader(
                title: 'Accounts',
                // rightWidget: IconButton(
                //     icon: Icon(FlutterIcons.sliders_fea, color: hghlgtBlue),
                //     onPressed: null),
              ),
            ]),
            Expanded(
              child: Center(
                child: Text(
                  'Transactions\nUnder Construction',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: FlatButton(
                  color: hghlgtBlue,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  // onPressed: () => Navigator.pushNamed(context, "/accounts/??/new"),
                  onPressed: () => print("new txn"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardAccount extends StatelessWidget {
  final Account acc;
  CardAccount(this.acc);
  AccountController accCtrl = Get.find();

  final moneyFm = new NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ((MediaQuery.of(context).size.height / 10) * 1.25) + 10,
      ),
      decoration: BoxDecoration(
        color: catColour(acc.type),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${acc.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                Text('${moneyFm.format(acc.balance)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800)),
                Text('${acc.type}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(FlutterIcons.settings_fea, color: Colors.white),
            onPressed: () {
              // print(acc.toJson());
              accCtrl.acc.value = Account.fromJson(acc.toJson());
              // print(accCtrl.acc().toJson());
              accCtrl.accNameField.text = acc.name;
              if (acc.balance < 0) {
                accCtrl.isNegBalance.value = true;
                accCtrl.accBalanceField.text = (acc.balance * -1).toString();
              } else {
                accCtrl.accBalanceField.text = acc.balance.toString();
              }
              Navigator.pushNamed(context, "/accounts/edit");
            },
          )
        ],
      )),
    );
  }
}

class TransactionLists extends StatelessWidget {
  final String title;
  final String txnType;

  TransactionLists({this.title, this.txnType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: <Widget>[
              //Icon
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Icon(
                    txnType == "income"
                        ? Icons.date_range
                        : Icons.directions_car,
                    color: Colors.lightBlue[900]),
                padding: EdgeInsets.all(12),
              ),
              SizedBox(width: 10),
              // Title + Category
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900])),
                  Text('Payment from Saad',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500]))
                ],
              )),
              // Amount + Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    (txnType == "income" ? "+" : "-") + "\$500.5",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: txnType == "income"
                            ? Colors.lightGreen
                            : Colors.orange),
                  ),
                  Text(
                    "26 Jan",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500]),
                  ),
                ],
              )
            ],
          ),
        );
      },
      shrinkWrap: true,
      itemCount: 2,
      padding: EdgeInsets.all(0),
      controller: ScrollController(keepScrollOffset: false),
    );
  }
}
