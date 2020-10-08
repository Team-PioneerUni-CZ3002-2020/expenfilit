import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:Expenfilit/Controller/auth.controller.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:Expenfilit/View/components/navigator/model_destination.dart';
import 'package:Expenfilit/View/components/navigator/navigator_destination.dart';
import 'package:Expenfilit/View/components/colours.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);

    return StreamProvider<SessionUser>.value(
      value: AuthController(userUid: user.uid).userData,
      child: Scaffold(
        backgroundColor: themeGreyWhite,
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _currentIndex,
            children: allDestinations.map<Widget>((Destination destination) {
              return DestinationNavigator(destination: destination);
            }).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => {
            setState(() {
              _currentIndex = i;
            })
          },
          items: allDestinations.map((Destination destination) {
            return BottomNavigationBarItem(
                icon: Icon(destination.icon), label: destination.label);
          }).toList(),
          showUnselectedLabels: true,
          iconSize: 26,
          selectedItemColor: hghlgtBlue,
          unselectedItemColor: icUnselectGrey,
          unselectedFontSize: 10.0,
          selectedFontSize: 10.0,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
