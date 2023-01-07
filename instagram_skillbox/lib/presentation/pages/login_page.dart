import 'package:flutter/material.dart';
import 'package:instagram_skillbox/presentation/widgets/login_reg_form.dart';

String userEmail = "";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const LoginRegForm(),
    );
  }
}
