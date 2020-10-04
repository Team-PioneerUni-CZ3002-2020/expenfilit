import 'package:Expenfilit/Controller/auth_controller.dart';
import 'package:Expenfilit/Helpers/header_background.dart';
import 'package:Expenfilit/Helpers/loading.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenfilit/Helpers/constants.dart';

class SettingsTab extends StatelessWidget {
  final AuthController _auth = AuthController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);

    return user == null
        ? Loading()
        : Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Container(
              child: Column(children: <Widget>[
                // -------- vvv HEADER vvv -------- //
                Expanded(
                  flex: 3,
                  child: Stack(children: <Widget>[
                    headerBackground,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text(
                                  user.displayName ?? " ",
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
                        ],
                      ),
                    ),
                  ]),
                ),
                // -------- ^^^ HEADER ^^^ -------- //
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
          );
  }
}
