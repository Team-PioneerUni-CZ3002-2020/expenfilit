import 'package:Expenfilit/Helpers/header_background.dart';
import 'package:Expenfilit/Helpers/loading.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenfilit/Helpers/constants.dart';

class AccountsTab extends StatefulWidget {
  @override
  _AccountsTabState createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  FontWeight addAccBtnFontWeight = FontWeight.w500;

  void onAddAccount() async {
    setState(() {
      addAccBtnFontWeight = FontWeight.w700;
    });
  }

  TextStyle cardCatTitleStyle = TextStyle(
      color: themeDarkBlack, fontWeight: FontWeight.w800, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);
    return user == null
        ? Loading()
        : Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Container(
              child: Column(
                children: <Widget>[
                  // -------- vvv HEADER vvv -------- //
                  Expanded(
                    flex: 3,
                    child: Stack(children: <Widget>[
                      headerBackground,
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TOTAL",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: hghlgtYellow,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    print('onAddAccount pressed');
                                    onAddAccount();
                                  },
                                  child: Text(
                                    'ADD ACCOUNT',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: addAccBtnFontWeight,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(0),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '\$0.00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                  // -------- ^^^ HEADER ^^^ -------- //
                  Expanded(
                      flex: 12,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cash Wallet', style: cardCatTitleStyle),
                                  Text('0.00 SGD', style: cardCatTitleStyle)
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 180,
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: hghlgtBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Default Account',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '0.00 SGD',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                            SizedBox(height: 35),
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: double.infinity),
                                child: FlatButton(
                                    // minWidth: double.infinity,
                                    child: Text(
                                      'Add Account',
                                      style: TextStyle(
                                          color: themeDarkerBlack,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: themeDarkerBlack, width: 3)),
                                    onPressed: () {
                                      print("add account pressed");
                                    }))
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
  }
}
