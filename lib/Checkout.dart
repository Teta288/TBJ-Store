import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'package:intl/intl.dart';

final _currencyFormat = NumberFormat.currency(symbol: '\$');

class payNow extends StatelessWidget {
  const payNow({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Checkout_tab(),
    );
  }
}

class Checkout_tab extends StatefulWidget {
  const Checkout_tab({super.key});

  @override
  State<Checkout_tab> createState() => _Checkout_tabState();
}

class _Checkout_tabState extends State<Checkout_tab> {
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final cvcController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context, listen: false);
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Pay Now'),
        ),
        // Add safe area widget to place the CupertinoFormSection below the navigation bar.

        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: CupertinoColors.extraLightBackgroundGray,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Card Information',
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoTextField(
                  prefix: Text('Name on Card:'),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  //   onFieldSubmitted: _handleSubmitted,
                  textCapitalization: TextCapitalization.words,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  placeholder: 'Janvier',
                ),
                CupertinoTextField(
                  prefix: Text('Card Number :'),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  controller: cardController,
                  textInputAction: TextInputAction.next,
                  //   onFieldSubmitted: _handleSubmitted,
                  textCapitalization: TextCapitalization.words,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  placeholder: '123456789',
                ),
                CupertinoTextField(
                  prefix: Text('Date:'),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  controller: dateController,
                  textInputAction: TextInputAction.next,
                  //   onFieldSubmitted: _handleSubmitted,
                  textCapitalization: TextCapitalization.words,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  placeholder: 'MM/YY',
                ),
                CupertinoTextField(
                  prefix: Text('Card Verification code :'),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  controller: cvcController,
                  textInputAction: TextInputAction.next,
                  //   onFieldSubmitted: _handleSubmitted,
                  textCapitalization: TextCapitalization.words,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ),
                  placeholder: 'CVC',
                ),
                CupertinoButton(
                    color: CupertinoColors.black,
                    child: Text(
                      'Pay ${_currencyFormat.format(model.totalCost)}',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}
