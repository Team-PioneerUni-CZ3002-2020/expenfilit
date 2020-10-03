import 'package:Expenfilit/Controller/auth_controller.dart';
import 'package:Expenfilit/Helpers/loading.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                Expanded(
                  flex: 3,
                  child: Stack(children: <Widget>[
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(64, 123, 252, 1),
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
                        //color: Color.fromRGBO(64, 123, 252, 1),
                        child: (Container(
                          // color: Colors.red,
                          // width: 30,
                          // height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/header_bg_sm.png'),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              user.displayName ?? Loading(),
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Point\$ ${user.points ?? 0}',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 7,
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
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 145.0, vertical: 15.0),
                        child: Text('Log Out',
                            style: TextStyle(
                                color: Color.fromRGBO(224, 36, 94, 1))),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Color.fromRGBO(224, 36, 94, 1))),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                    ))
              ]),
            ),
          );
  }
}
