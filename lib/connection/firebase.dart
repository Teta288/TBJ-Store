import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> addOrder(name, email, phoneno, Loc, Cartproducts) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid().v4();
  print(name);
  await _firestore.collection("orders").doc(uuid).set({
    'name': name,
    'Location': Loc,
    'Email': email,
    'Phone Number': phoneno,
    'Ordered products': Cartproducts,
    'Ordering time': DateTime.now()
  });
//send Email
  void sendEmail() async {
    var time = DateTime.now();
    String username = 'belindahteta28@gmail.com';
    String appPassword = 'nexzkyekkpfgchcu';
    final smtpServer = gmail(username, appPassword);
    var finalMessage =
        '<h3>You got a new order from $name at $time / User number is $phoneno, Location is $Loc. This is the description of the order:</h3>';

// Loop through Cartproducts array
    for (var i = 0; i < Cartproducts.length; i++) {
      var product = Cartproducts[i];
      var productName = product['name'];
      //var productPrice = product.price;

      // Add product details to the message
      finalMessage += '<p>Name: ' + productName + '</p>';
    }
    ;

    final message = Message()
      ..from = Address(username)
      ..recipients.add(username)
      ..subject = ' New Order Alert '
      ..html = finalMessage;
    // '<h3> You got a new order from $name at $time / User number is $phoneno, Location is $Loc, This is the description of the order $Cartproducts</h3>';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent');
    } on MailerException catch (e) {
      print('Message not sent' + e.toString());
    }
  }

  sendEmail();
  return;
}
