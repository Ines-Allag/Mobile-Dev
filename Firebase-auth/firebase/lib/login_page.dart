import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'auth_service.dart';
import 'reset_password.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final loginEmail =TextEditingController();
  final loginPwd =TextEditingController();
  final service =AuthService();

  void login() async{
    if (!service.isValidEmail(loginEmail.text)){
      showMsg("Invalid Email");
      return;
    }
    if(loginPwd.text.isEmpty){
      showMsg("Insert Password");
      return;
    }
    await service.login(
      loginEmail.text,
      loginPwd.text,
    );
  }

  void showMsg(String msg){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content:Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
              TextField(
              controller: loginEmail,
              decoration: const InputDecoration(labelText: "Email"),
            ), // TextField
            TextField(
              controller: loginPwd,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ), // TextField
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ), // ElevatedButton
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Resetpage()),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't you have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupPage(),
                          ), // MaterialPageRoute
                        );
                      },
                      child: const Text("Signup"),
                    ), // TextButton
                  ],
                ), // Row
              ],
            ), // Column
        ), // Padding
    ); // Scaffold
  }
}
