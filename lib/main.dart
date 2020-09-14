import 'package:flutter/material.dart';
import 'package:expenfilit_v1/Controller/expenfilit_notifier.dart';
import 'package:expenfilit_v1/Controller/auth_notifier.dart';
import 'package:expenfilit_v1/Model/user.dart';
import 'package:expenfilit_v1/View/signin_signup.dart';
import 'package:provider/provider.dart';

import 'View/homepage.dart';

///Notify Auth, Review and Favourite Notifiers
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        builder: (context) => AuthNotifier(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenfilit',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? HomePage() : Signinsignup();
        },
      ),
    );
  }
}