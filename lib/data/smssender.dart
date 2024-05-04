import 'package:http/http.dart' as http;
import 'dart:convert';

class SmsSender {
  final String apiUrl;
  final String apiKey;

  SmsSender({required this.apiUrl, required this.apiKey});

  Future<void> sendSms(String phoneNumber, String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(<String, String>{
        'to': phoneNumber,
        'message': message
      }),
    );

    if (response.statusCode == 200) {
      print("SMS sent successfully!");
    } else {
      print("Failed to send SMS: ${response.body}");
    }
  }
}
