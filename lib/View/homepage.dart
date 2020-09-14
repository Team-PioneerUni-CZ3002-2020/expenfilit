import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:expenfilit_v1/Controller/expenfilit_notifier.dart';
import 'package:expenfilit_v1/Controller/auth_notifier.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  onChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () => signout(authNotifier),
        child: Text(
          "Logout",
          style: TextStyle(fontSize: 20, color: Colors.tealAccent),
        ),
      ),
    );
  }
  
}