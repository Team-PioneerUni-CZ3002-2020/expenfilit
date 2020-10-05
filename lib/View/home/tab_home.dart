import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Center(
        child: Text(
          'Home Tab\nUnder Construction',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
