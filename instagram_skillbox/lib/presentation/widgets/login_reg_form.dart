import 'package:flutter/material.dart';

import '../../domain/firebase_func.dart';

class LoginRegForm extends StatefulWidget {
  const LoginRegForm({super.key});

  @override
  State<LoginRegForm> createState() => _LoginRegFormState();
}

TextEditingController loginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginRegFormState extends State<LoginRegForm> {
  bool isRegistered = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Column(
              children: [
                TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                      hintText: "E-mail", labelText: "E-mail"),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Пароль", labelText: "Пароль"),
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    isRegistered ? login(context) : registration();
                    setState(() {
                      isRegistered = true;
                    });
                  },
                  minWidth: 150,
                  child: Text(isRegistered ? "Войти" : "Регистрация"),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isRegistered
                  ? "Еще не зарегистрированы?"
                  : "Уже зарегистрированы?"),
              TextButton(
                  onPressed: () => setState(() {
                        if (isRegistered) {
                          isRegistered = false;
                        } else {
                          isRegistered = true;
                        }
                      }),
                  child: Text(isRegistered ? "Регистрация" : "Войти"))
            ],
          )
        ],
      ),
    );
  }
}
