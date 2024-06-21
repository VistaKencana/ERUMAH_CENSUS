import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Masuk"),
            const CustomTextField(title: "ID Pengguna"),
            const CustomTextField(
              title: "Kata Laluan",
              obscureText: true,
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RoutesName.home),
                  child: const Text("Log Masuk")),
            )
          ],
        ),
      ),
    );
  }
}
