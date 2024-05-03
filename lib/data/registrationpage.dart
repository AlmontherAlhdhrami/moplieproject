import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
      body: 'Name: $_name\nPhone: $_phoneNumber\nDate: $_selectedDate\nPrice: \$${widget.court.courtData?.ticketPrice ?? 0}\n\nJoin the conversation: https://chat.google.com',
      subject: 'Court Visit Registration',
      recipients: ['asfz.2000@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      if (!mounted) return;  // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email sent successfully!")));
    } catch (e) {
      if (!mounted) return;  // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send email: $e")));
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
