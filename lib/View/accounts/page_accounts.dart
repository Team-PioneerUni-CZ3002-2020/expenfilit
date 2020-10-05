import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Expenfilit/View/components/colours.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key key, this.setTabIndex}) : super(key: key);

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

class Temp extends StatelessWidget {
  const Temp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 10) * 1.4,
      child: Stack(children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        FlutterIcons.arrow_left_fea,
                        size: 30,
                        color: themeBlack,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Accounts',
                      style: TextStyle(
                        color: themeBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                      icon: Icon(FlutterIcons.sliders_fea, color: hghlgtBlue),
                      onPressed: null)
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
