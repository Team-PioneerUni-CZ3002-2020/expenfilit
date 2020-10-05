import 'package:Expenfilit/View/components/headers.dart';
import 'package:flutter/material.dart';
import 'package:Expenfilit/View/components/colours.dart';

import 'component_acc_cat.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({Key key, this.setTabIndex}) : super(key: key);

  final Function setTabIndex;
  @override
  Widget build(BuildContext context) {
    const List<String> types = [
      "Bank Account",
      "Credit Card",
      "Cash",
      "Loans",
      "Investments",
      "Insurance"
    ];

    return Scaffold(
      backgroundColor: themeGreyWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Container(
          child: Column(children: <Widget>[
            // -------- vvv HEADER vvv -------- //
            WhiteTitleHeader(
              title: 'Add Account',
              rightWidget: SizedBox(width: 50),
            ),
            // -------- ^^^ HEADER ^^^ -------- //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'What account type are we adding?',
                style: TextStyle(
                  color: themeDarkerBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: types.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.85,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) => AccGridCard(
                  accCardType: types[index],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
