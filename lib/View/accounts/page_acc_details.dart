import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Expenfilit/View/components/colours.dart';

class AccountsDetailsPage extends StatelessWidget {
  const AccountsDetailsPage({Key key, this.setTabIndex}) : super(key: key);

  final Function setTabIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Container(
          child: Column(children: <Widget>[
            WhiteTitleHeader(
              title: 'Accounts',
              rightWidget: IconButton(
                  icon: Icon(FlutterIcons.sliders_fea, color: hghlgtBlue),
                  onPressed: null),
            ),
            SizedBox(height: 100),
            Center(
              child: Text(
                'Page Under Construction',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
