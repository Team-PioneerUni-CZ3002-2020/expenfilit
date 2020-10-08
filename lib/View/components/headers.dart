import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/View/components/colours.dart';

var patternHeaderBg = Stack(children: <Widget>[
  Center(
    child: Container(
      decoration: BoxDecoration(
        color: hghlgtBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
  ),
  Center(
    child: Container(
      // padding: const EdgeInsets.all(10),
      //color: hghlgtBlue,
      child: (Container(
        // color: Colors.red,
        // width: 30,
        // height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/header_bg_sm.png'),
              fit: BoxFit.contain),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      )),
    ),
  )
]);

class WhiteTitleHeader extends StatelessWidget {
  const WhiteTitleHeader({
    Key key,
    this.title,
    this.rightWidget,
  }) : super(key: key);

  final String title;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 10) * 1.25,
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
              SizedBox(height: (MediaQuery.of(context).size.height / 10) * 0.3),
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
                      title,
                      style: TextStyle(
                        color: themeBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  rightWidget
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class BluePatternHeader extends StatelessWidget {
  const BluePatternHeader({
    Key key,
    this.assetSum,
    this.user,
  }) : super(key: key);

  final String assetSum;
  final SessionUser user;

  @override
  Widget build(BuildContext context) {
    final bool isSettingsTab = assetSum == null && user != null;

    return Container(
      height: (MediaQuery.of(context).size.height / 15) * 3,
      margin: EdgeInsets.only(bottom: isSettingsTab ? 0 : 15),
      child: Stack(children: <Widget>[
        patternHeaderBg,
        Container(
          padding: isSettingsTab
              ? EdgeInsets.symmetric(horizontal: 20)
              : EdgeInsets.only(left: 25, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isSettingsTab
                ? <Widget>[
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            user.accName ?? " ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Point\$ ${user.points ?? 0}',
                            style: TextStyle(
                              color: hghlgtYellow,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]
                : <Widget>[
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
                            Navigator.pushNamed(context, "/addAccount");
                          },
                          child: Text(
                            'ADD ACCOUNT',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                          // '\$0.00',
                          assetSum,
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
    );
  }
}
