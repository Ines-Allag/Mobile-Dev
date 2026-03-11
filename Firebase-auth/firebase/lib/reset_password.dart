import "package:flutter/material.dart";
import 'auth_service.dart';

class Resetpage extends StatefulWidget {
  const Resetpage({super.key});

  @override
  State<Resetpage> createState() => _ResetPageState();
}

class _ResetPageState extends State<Resetpage>{
  final service = AuthService();
  final email = TextEditingController();


 void resetPassword() async {
    if (email.text.isEmpty) {
      showMsg("Enter your email");
      return;
    }
    try {
      await service.resetPassword(email: email.text);
      showMsg("Reset email sent! Check your inbox");
    } catch (e) {
      showMsg(e.toString());
    }
 }

  void showMsg(String msg){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }



@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
              children: [
              TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email")), // TextField
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: resetPassword,
                  child: const Text("Send Reset Email"),
                ),
              ],
          ),
      ),
  );
}
}
