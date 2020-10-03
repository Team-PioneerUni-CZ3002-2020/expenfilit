import 'package:Expenfilit/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/signin_signup.dart';
import 'home/homepage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SessionUser>(context);
    //print(user);
    // return either the Home or Authenticate widget
    return user == null ? Signinsignup() : HomePage();
  }
}
