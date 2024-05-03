import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/court_model.dart';

class RegistrationPage extends StatefulWidget {
  final Court court;
  RegistrationPage({Key? key, required this.court}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phoneNumber = '';
  DateTime _selectedDate = DateTime.now();

  void _sendEmail() async {
    final Email email = Email(
      body: 'Name: $_name\nPhone: $_phoneNumber\nDate: $_selectedDate\nPrice: \$${widget.court.courtData?.ticketPrice ?? 0}',
      subject: 'Court Visit Registration',
      recipients: ['asfz.2000@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email sent successfully")));
    } catch (e) {
      if (e.toString().contains("No email clients found")) {
        String encodedBody = Uri.encodeComponent(email.body);
        String encodedSubject = Uri.encodeComponent(email.subject);
        String encodedRecipients = Uri.encodeComponent(email.recipients.join(","));
        String fallbackUrl = "https://mail.google.com/mail/?view=cm&fs=1&to=$encodedRecipients&su=$encodedSubject&body=$encodedBody";
        if (await canLaunch(fallbackUrl)) {
          await launch(fallbackUrl);
        } else {
          print("Failed to launch URL: $fallbackUrl");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch web email client")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send email: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register for ${widget.court.courtData?.name}'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[800]!],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                  onSaved: (value) => _phoneNumber = value!,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _sendEmail();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue[800], backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class EmailSender {
  static Future<void> sendEmail({
    required String name,
    required String phoneNumber,
    required DateTime selectedDate,
    required double ticketPrice,
    required List<String> recipients,
    required String subject,
  }) async {
    final Email email = Email(
      body: 'Name: $name\nPhone: $phoneNumber\nDate: $selectedDate\nPrice: \$$ticketPrice',
      subject: subject,
      recipients: recipients,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }
}

class SMSSender {
  static Future<void> sendSMS({
    required String phoneNumber,
    required String message,
    required BuildContext context,
  }) async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number is empty."), backgroundColor: Colors.red),
      );
      return;
    }

    String smsUrl = "sms:$phoneNumber?body=$message";
    try {
      if (await canLaunch(smsUrl)) {
        await launch(smsUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("SMS sending initiated."), backgroundColor: Colors.green),
        );
      } else {
        throw 'Could not launch SMS';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send SMS: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}