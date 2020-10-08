import 'package:flutter/material.dart';
import 'package:Expenfilit/Model/account.dart';
import 'package:intl/intl.dart';
import 'package:Expenfilit/View/components/colours.dart';

class AccountCategory extends StatelessWidget {
  final List<Account> accounts;

  const AccountCategory({
    Key key,
    this.accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyFm = new NumberFormat.simpleCurrency();
    double accSum = accounts.length > 0
        ? accounts.map((a) => a.balance).fold(0, (p, c) => p + c)
        : 0;
    // String currency = accounts[0].currency ?? "SGD";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Bank Account",
              Text(accounts[0].type,
                  style: TextStyle(
                      color: themeDarkBlack,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              // Text('0.00 SGD',
              Text('${moneyFm.format(accSum)}',
                  style: TextStyle(
                      color: themeDarkBlack,
                      fontWeight: FontWeight.w800,
                      fontSize: 14))
            ],
          ),
          GridView.builder(
            padding: EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: accounts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.85,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15),
            itemBuilder: (context, index) => AccGridCard(
              acc: accounts[index],
              press: () => Navigator.pushNamed(context, "/accounts/details"),
            ),
          ),
        ],
      ),
    );
  }
}

class AccGridCard extends StatelessWidget {
  final String accCardType;
  final Account acc;
  final Function press;

  const AccGridCard({
    Key key,
    this.accCardType,
    this.acc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyFm = new NumberFormat.simpleCurrency();

    var cardColor = hghlgtBlue;

    final isAccountInfoCard = acc == null;

    switch (isAccountInfoCard ? accCardType : acc.type) {
      case 'Bank Account':
        cardColor = graphBlue;
        break;
      case 'Credit Card':
        cardColor = hghlgtRed;
        break;
      case 'Investments':
        cardColor = hghlgtYellow;
        break;
      case 'Loans':
        cardColor = hghlgtGreen;
        break;
      case 'Cash Wallet':
      case 'Cash':
        cardColor = hghlgtBlue;
        break;
      case 'Insurance':
        cardColor = icUnselectGrey;
        break;
      default:
        cardColor = graphBlue;
    }

    return GestureDetector(
      onTap: press,
      child: Container(
        // width: 180,
        // height: 100,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: acc == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: acc == null
              ? <Widget>[
                  Text(
                    accCardType,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]
              : <Widget>[
                  Text(
                    // 'Default Account',
                    acc.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    // '0.00 SGD',
                    // '${moneyFm.format(acc.balance)} ${acc.currency ?? 'SGD'}',
                    '${moneyFm.format(acc.balance)}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
        ),
      ),
    );
  }
}
