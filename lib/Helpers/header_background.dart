import 'package:flutter/material.dart';
import 'package:Expenfilit/Helpers/constants.dart';

var headerBackground = Stack(children: <Widget>[
  Center(
    child: Container(
      decoration: BoxDecoration(
        color: hghlgtBlue,
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
      //color: hghlgtBlue,
      child: (Container(
        // color: Colors.red,
        // width: 30,
        // height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/header_bg_sm.png'),
              fit: BoxFit.contain),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      )),
    ),
  )
]);
