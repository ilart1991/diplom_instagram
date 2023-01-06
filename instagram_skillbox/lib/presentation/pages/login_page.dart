import 'package:flutter/material.dart';
import 'package:instagram_skillbox/presentation/widgets/login_reg_form.dart';

String userEmail = "";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const LoginRegForm(),
    );
  }
}
