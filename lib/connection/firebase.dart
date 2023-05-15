import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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

  void sendEmail() async {
    var time = DateTime.now();
    String username = 'belindahteta28@gmail.com';
    String password = 'nexzkyekkpfgchcu';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(email)
      ..subject = ' New Order Alert '
      ..html =
          '<h3> You got a new order from $name at $time / User number is $phoneno, Location is $Loc</h3>';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent');
    } on MailerException catch (e) {
      print('Message not sent' + e.toString());
    }
  }

  //send email
  /* Future sendEmail() async {
    print("we are in email");
    var time = DateTime.now();
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_l2f76ze";
    const templateId = "template_i44px1q";
    const userId = "1qcTahHJI7bq88Q7E";
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "user_name": name,
            "user_subject": 'New Order',
            "user_message":
                'You got a new order from $name at $time / My number is $phoneno, Location is $Loc',
            "user_email": email
          }
        }));
    print('after email');
    print(response.statusCode);

    return response.statusCode;
  }

  await sendEmail();*/
  //sendEmail();
  /* sendEmail() async {
    var time = DateTime.now();
    String recepient = 'belindahteta28@gmail.com';
    String subject = 'New Order Alert';
    String body =
        'You got a new order from $name at $time / User number is $phoneno, Location is $Loc';

    final Uri email = Uri(
      scheme: 'mailto',
      path: recepient,
      query: 'subject=' +
          Uri.encodeComponent(subject) +
          '&body=' +
          Uri.encodeComponent(body),
    );
    if (await canLaunchUrl(email)) {
      await launchUrl(email);
    } else {
      debugPrint('error');
    }
  }*/

  sendEmail();
  return;
}
