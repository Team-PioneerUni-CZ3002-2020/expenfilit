import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';

class ManageAccountPage extends StatelessWidget {
  const ManageAccountPage({Key key, this.setTabIndex, this.title})
      : super(key: key);
  final title;

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
              title: title,
              rightWidget: Container(
                child: FlatButton(
                  minWidth: 0,
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () => print('save pressed'),
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
