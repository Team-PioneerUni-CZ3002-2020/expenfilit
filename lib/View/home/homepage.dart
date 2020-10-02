import 'package:Expenfilit/Controller/auth_controller.dart';
import 'package:Expenfilit/View/accounts/account_tab.dart';
import 'package:Expenfilit/View/challenges/challenge_tab.dart';
import 'package:Expenfilit/View/settings/setting_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController _auth = AuthController();

  var screens = [
    HomeTab(),
    AccountsTab(),
    ChallengesTab(),
    SettingsTab()
  ]; // screens for each tab

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('logout'),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ]),
      backgroundColor: Color.fromRGBO(230, 236, 240, 1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Accounts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.military_tech), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'You')
        ],
        onTap: (i) => {
          setState(() {
            selectedTab = i;
          })
        },
        showUnselectedLabels: true,
        iconSize: 30,
        selectedItemColor: Color.fromRGBO(64, 123, 252, 1),
        unselectedItemColor: Color.fromRGBO(101, 119, 134, 1),
      ),
      body: screens[selectedTab],
    );
  }
}
