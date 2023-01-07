import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_skillbox/domain/providers/registered_provider.dart';

import '../../domain/firebase_func.dart';

TextEditingController loginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginRegForm extends ConsumerWidget {
  const LoginRegForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegistered = ref.watch(registeredProvider);
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
                    isRegistered
                        ? ref.read(registeredProvider.notifier).notReg()
                        : ref.read(registeredProvider.notifier).isReg();
                  },
                  minWidth: 150,
                  child: Text(isRegistered as bool ? "Войти" : "Регистрация"),
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
                  onPressed: () {
                    isRegistered
                        ? ref.read(registeredProvider.notifier).notReg()
                        : ref.read(registeredProvider.notifier).isReg();
                  },
                  child: Text(isRegistered ? "Регистрация" : "Войти"))
            ],
          )
        ],
      ),
    );
  }
}
