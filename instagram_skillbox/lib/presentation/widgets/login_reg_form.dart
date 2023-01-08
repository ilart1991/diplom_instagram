import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_skillbox/domain/providers/registered_provider.dart';
import 'package:localization/localization.dart';

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
                  key: const Key("e-mail"),
                  controller: loginController,
                  decoration: const InputDecoration(labelText: "E-mail"),
                ),
                TextField(
                  key: const Key("password"),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "password".i18n()),
                ),
                MaterialButton(
                  key: const Key("logReg"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    if (isRegistered) {
                      login(context);
                      return;
                    } else {
                      registration();
                    }

                    isRegistered
                        ? ref.read(registeredProvider.notifier).notReg()
                        : ref.read(registeredProvider.notifier).isReg();
                  },
                  minWidth: 150,
                  child: Text(
                      isRegistered as bool ? "enter".i18n() : "reg".i18n()),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  isRegistered ? "reg_question".i18n() : "log_question".i18n()),
              TextButton(
                  onPressed: () {
                    isRegistered
                        ? ref.read(registeredProvider.notifier).notReg()
                        : ref.read(registeredProvider.notifier).isReg();
                  },
                  child: Text(isRegistered ? "reg".i18n() : "enter".i18n()))
            ],
          )
        ],
      ),
    );
  }
}
