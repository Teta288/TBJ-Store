import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';
import 'package:uuid/uuid.dart';

Future<void> addOrder() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid().v4();
  await _firestore.collection("orders").doc(uuid).set({
    'name': "Dave",
    'Location': "Kigali",
    'Email': "david@gmail.com",
    'Delivery time': "hello"
  });
  return;
}
