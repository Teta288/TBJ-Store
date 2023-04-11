import 'package:cupertino_store/connection/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:js_util';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'connection/firebase.dart';

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
              child: _buildOrderButton(_controller, _controller1, _controller2),
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

/*_showDiAlog(BuildContext context){
    showDialog(
        context: context,
        child:   CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Text("TBJ store"),
            
            ],
          ),
          content: new Text('Thank you for shopping'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },),
           
          ],
        ));
  }*/

Widget _buildOrderButton(name, email, phoneno) {
  return Container(
    child: CupertinoButton(
      color: Colors.black,
      child: Text('Order'),
      onPressed: () {
        addOrder(name.text, email.text, phoneno.text);

        /* if (name.text.isEmpty || email.text.isEmpty || phoneno.text.isEmpty)  {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('error'),
                    content: Text('Phone Field is Empty'),
                  
                  );
                });
          } else {
    
              return _showDiAlog(context);
            }
            // Validation passed
          }*/

        /*Map<String, String> dataToSave = {
          'name': _controller.text,
          'email': _controller1.text,
          "location": _controller2.text,
          "Order Time": DateTime.now()
        };
        //FirebaseFirestore.instance.collection('Orders').add(dataToSave);*/
        //print(name.text);
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
