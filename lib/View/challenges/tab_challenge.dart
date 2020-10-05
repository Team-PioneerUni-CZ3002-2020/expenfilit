import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';

class ChallengesTab extends StatelessWidget {
  const ChallengesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Center(
        child: Text(
          'Challenge Tab\nUnder Construction',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
