import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Expenfilit/Model/user.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Controller/auth_controller.dart';
import 'View/wrapper.dart';

///Notify Auth, Review and Favourite Notifiers
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StreamProvider<SessionUser>.value(
      value: AuthController().user,
      child: MaterialApp(
        title: 'Expenfilit',
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: Colors.teal,
          accentColor: Colors.yellowAccent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
