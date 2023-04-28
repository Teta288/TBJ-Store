import 'package:cupertino_store/connection/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'styles.dart';
//import 'package:firebase_database/firebase_database.dart';

/*var uuid = Uuid().v4();
CollectionReference ref = FirebaseFirestore.instance.collection('Orders');
const double _kDateTimePickerHeight = 216;
final now = DateTime.now();

FirebaseFirestore firestore = FirebaseFirestore.instance;*/

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  const ShoppingCartTab({super.key});

  @override
  State<ShoppingCartTab> createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String? name;
  String? email;
  String? location;
  String? pin;

  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');
  final _controller1 = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int _selectedloc = 0;

  double _kItemExtent = 32.0;
  List<String> _location = <String>[
    'Gasabo',
    'Bugesera',
    'Huye',
    'Nyamata',
    'Kicukiro',
    'Nyarugenge',
    'Nyagatare',
    'Rwamagana',
    'Musanze',
  ];
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        Container(
          child: CupertinoTextFormFieldRow(
            prefix: Icon(
              CupertinoIcons.person_solid,
              color: CupertinoColors.lightBackgroundGray,
              size: 28,
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            controller: _controller,
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
            placeholder: 'Name',
          ),
        ),
        SizedBox(),
        Container(
          child: CupertinoTextFormFieldRow(
            prefix: Icon(
              CupertinoIcons.mail_solid,
              color: CupertinoColors.lightBackgroundGray,
              size: 28,
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            controller: _controller1,
            // onFieldSubmitted: _handleSubmitted,
            textCapitalization: TextCapitalization.words,
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 0, color: CupertinoColors.inactiveGray),
              ),
            ),
            placeholder: 'Email',
          ),
        ),
        SizedBox(),
        Container(
          child: CupertinoTextFormFieldRow(
            prefix: Icon(
              CupertinoIcons.phone,
              color: CupertinoColors.lightBackgroundGray,
              size: 28,
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            controller: _controller2,
            textCapitalization: TextCapitalization.words,
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 0, color: CupertinoColors.inactiveGray),
              ),
            ),
            placeholder: 'Phone Number',
          ),
        ),
        SizedBox(),
        Container(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showDialog(
              CupertinoPicker(
                itemExtent: _kItemExtent,
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {
                    _selectedloc = selectedItem;
                  });
                },
                children: List<Widget>.generate(_location.length, (int index) {
                  return Center(
                    child: Text(
                      _location[index],
                    ),
                  );
                }),
              ),
            ),
            child: Text(
              _location[_selectedloc],
              style: const TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /* Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            ),
          ],
        ),
        SizedBox(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }*/

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index - 2;
        switch (index) {
          /*  case 0:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildNameField(),
            );
          case 1:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildEmailField(),
            );
          case 2:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildLocationField(),
            );*/
          case 0:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: _buildForm(),
            );
          case 1:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _buildOrderButton(_controller, _controller1, _controller2,
                  context, context, _location),
            );
          default:
            if (model.productsInCart.length > productIndex) {
              return ShoppingCartItem(
                index: index,
                product: model.getProductById(
                    model.productsInCart.keys.toList()[productIndex]),
                quantity: model.productsInCart.values.toList()[productIndex],
                lastItem: productIndex == model.productsInCart.length - 1,
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == productIndex &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Shipping '
                          '${_currencyFormat.format(model.shippingCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tax ${_currencyFormat.format(model.tax)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total ${_currencyFormat.format(model.totalCost)}',
                          style: Styles.productRowTotal,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            )
          ],
        );
      },
    );
  }
}

Widget _buildOrderButton(name, email, phoneno, context, context1, Loc) {
  return Container(
    child: CupertinoButton(
      color: Colors.black,
      child: Text('Order'),
      onPressed: () async {
        if (name.text.isEmpty || email.text.isEmpty || phoneno.text.isEmpty) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('error'),
                  content: Text('Check if any of the Fields is Empty'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        } else {
          /*showCupertinoDialog(
              context: context1,
              builder: (context1) {
                return CupertinoAlertDialog(
                  title: Text('Congrats'),
                  content: Text('Thank you for shopping'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Return'),
                      onPressed: () {
                        Navigator.pop(context1);
                      },
                    )
                  ],
                );
              });
              */
          await makePayment();
          showCupertinoDialog(
              context: context1,
              builder: (context1) {
                return CupertinoAlertDialog(
                  title: Text('Congrats'),
                  content: Text('Payment successfull'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Return'),
                      onPressed: () {
                        Navigator.pop(context1);
                      },
                    )
                  ],
                );
              });
          addOrder(name.text, email.text, phoneno.text, Loc.toString());
        }

        // Validation passed
      },
    ),
  );
}

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    required this.index,
    required this.product,
    required this.lastItem,
    required this.quantity,
    required this.formatter,
    super.key,
  });

  final Product product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: Styles.productRowItemName,
                        ),
                        Text(
                          formatter.format(quantity * product.price),
                          style: Styles.productRowItemName,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${quantity > 1 ? '$quantity x ' : ''}'
                      '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return row;
  }
}

Future<void> makePayment() async {
  Map<String, dynamic>? paymentIntent;
  try {
    paymentIntent = await createPaymentIntent('10000', 'GBP');

    var gpay = PaymentSheetGooglePay(
        merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

    //STEP 2: Initialize Payment Sheet
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent![
                    'client_secret'], //Gotten from payment intent
                style: ThemeMode.light,
                merchantDisplayName: 'Abhi',
                googlePay: gpay))
        .then((value) {});

    //STEP 3: Display Payment sheet
    displayPaymentSheet();
  } catch (err) {
    print('Hello error');
    print(err);
  }
}

displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet().then((value) {
      print("Payment Successfully");
    });
  } catch (e) {
    print('$e');
  }
}

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization':
            'Bearer sk_test_51MyEmZFQsYZxmyn48jbgvGxmGDlzhGDurxTSrdf3cOUIeprHPq5m1edcTHB1C2l5rqV50ngM0Y34R2o7sN41Irdx00SDoaz980',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    return json.decode(response.body);
  } catch (err) {
    throw Exception(err.toString());
  }
}
