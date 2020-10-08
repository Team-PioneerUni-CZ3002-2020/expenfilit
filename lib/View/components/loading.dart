import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Expenfilit/View/components/colours.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // print(height);
    return SizedBox(
      // height: 300,
      height: height,
      child: Center(
        child: Container(
            color: Colors.transparent,
            child: Center(
              child: SpinKitThreeBounce(
                color: hghlgtYellow,
                size: 40.0,
              ),
            )),
      ),
    );
  }
}
