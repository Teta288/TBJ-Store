import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';
import 'package:uuid/uuid.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

Future<void> addOrder(name, email, phoneno) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid().v4();
  print(name);
  await _firestore.collection("orders").doc(uuid).set({
    'name': name,
    //'Location': Loc,
    'Email': email,
    'Phone Number': phoneno,
    // 'Ordered products': savedProducts,
    'Ordering time': DateTime.now()
  });
  //send email
  Future sendEmail() async {
    print("we are in email");
    var time = DateTime.now();
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_4swt1zi";
    const templateId = "template_t0iy67n";
    const userId = "zKkb2vjvj0xFgjASQ";
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "name": name,
            "subject": 'New Order',
            "message": 'You got a new order from $name at $time',
            "user_email": email
          }
        }));
    print(response);
    return response.statusCode;
  }

  await sendEmail();
  /*void sendEmail() async {
    String username = name;
    String user_email = email;
    final SmtpServer = gmail(username, user_email);
    final message = Message()
      ..from = Address(email, name)
      ..recipients.add('belindahteta28@gmail.com')
      ..subject = 'Hi TBJ Store'
      ..text = 'Just Shopped!';

    try {
      final SendReport = await send(message, SmtpServer);
      print('Message sent:' + SendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.${e.toString()}');
    }
  }*/

  return;
}
