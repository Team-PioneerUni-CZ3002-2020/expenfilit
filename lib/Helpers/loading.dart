import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Expenfilit/Helpers/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Center(
          child: SpinKitThreeBounce(
            color: hghlgtYellow,
            size: 40.0,
          ),
        ));
  }
}
