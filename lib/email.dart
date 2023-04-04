/*import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String name, String email, String message) async {
  final smtpServer = gmail('yourEmail@gmail.com', 'yourPassword');

  final message = Message()
    ..from = Address('yourEmail@gmail.com')
    ..recipients.add('recipientEmail@gmail.com')
    ..subject = 'New message from $name'
    ..text = 'Name: $name\nEmail: $email\nMessage: $message';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.sent}');
  } catch (e) {
    print('Error sending email: $e');
  }
}

//String name = "Tona Brenda";
//String email = 'tonabrenda98@gmail.com';
//String message = 'Hello, this is my message.';
//await sendEmail(name,email,message);*/
