import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';
import 'package:uuid/uuid.dart';

Future<void> addOrder(name, email) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid().v4();
  print(name);
  await _firestore.collection("orders").doc(uuid).set({
    'name': name,
    'Location': "Kigali",
    'Email': email,
    'Delivery time': "hello"
  });
  return;
}
