import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenfilit/Controller/auth.service.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/View/components/headers.dart';
import 'package:Expenfilit/View/components/loading.dart';
import 'package:Expenfilit/View/components/colours.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);

    return user == null
        ? Loading()
        : Scaffold(
            backgroundColor: themeGreyWhite,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Container(
                child: Column(children: <Widget>[
                  BluePatternHeader(user: user),
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: ListTile.divideTiles(context: context, tiles: [
                        ListTile(
                          leading: Icon(Icons.lock_open_outlined),
                          title: Text('Reset Password'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          tileColor: Colors.white,
                          onTap: () {
                            _auth.sendPasswordResetEmail(user.email);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.perm_device_information),
                          title: Text('Version 0.1.0'),
                          tileColor: Colors.white,
                        ),
                      ]).toList(),
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: FlatButton(
                        child: Text('Log Out',
                            style: TextStyle(
                                color: hghlgtRed, fontWeight: FontWeight.w800)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 145.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: hghlgtRed, width: 2)),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
  }
}
