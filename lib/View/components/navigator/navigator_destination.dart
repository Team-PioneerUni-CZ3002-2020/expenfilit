import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'model_destination.dart';
import 'package:Expenfilit/View/components/navigator/route_tab.dart';
import 'package:Expenfilit/View/accounts/page_acc_details.dart';
import 'package:Expenfilit/View/accounts/page_acc_manage.dart';
import 'package:Expenfilit/View/accounts/page_acc_add.dart';

const List<Destination> allDestinations = <Destination>[
  Destination('Home', FlutterIcons.home_fea),
  Destination('Accounts', FlutterIcons.credit_card_fea),
  Destination('Challenges', FlutterIcons.award_fea),
  Destination('You', Icons.face),
];

class DestinationNavigator extends StatefulWidget {
  const DestinationNavigator({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState.canPop()) {
          _navigatorKey.currentState.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return TabRoute(
                    destination: widget.destination,
                  );
                case '/addAccount':
                  return AddAccountPage();
                case '/accounts/new/type':
                  return AccountListPage();
                case '/accounts/new':
                  return ManageAccountPage(title: 'New Account');
                case '/accounts/edit':
                  return ManageAccountPage(title: 'Edit Account');
                case '/accounts/details':
                  return AccountsDetailsPage();
              }
            },
          );
        },
      ),
    );
  }
}
