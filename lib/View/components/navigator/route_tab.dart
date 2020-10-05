import 'package:Expenfilit/View/accounts/tab_account.dart';
import 'package:Expenfilit/View/challenges/tab_challenge.dart';
import 'package:Expenfilit/View/home/tab_home.dart';
import 'package:Expenfilit/View/settings/tab_setting.dart';
import 'package:flutter/material.dart';
import 'model_destination.dart';

class TabRoute extends StatelessWidget {
  const TabRoute({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: destination.color[50],
      body: destination.label == "Home"
          ? HomeTab()
          : destination.label == "Accounts"
              ? AccountsTab()
              : destination.label == "Challenges"
                  ? ChallengesTab()
                  : destination.label == "You"
                      ? SettingsTab()
                      : Center(
                          child: Text('Route not found'),
                        ),
    );
  }
}
