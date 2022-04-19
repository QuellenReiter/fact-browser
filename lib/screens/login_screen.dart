import 'package:flutter/material.dart';
import 'package:fact_browser/provider/database_utils.dart';
import 'package:fact_browser/utilities/utilities.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.loginCallback}) : super(key: key);

  final Function loginCallback;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String? errorText;
  final db = DatabaseUtils();

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void loginCallback(bool success, String? errorMsg) {
    if (success) {
      widget.loginCallback(true);
    }
    if (errorMsg != null) {
      setState(() {
        errorText = errorMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText("Einloggen"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 400),
          child: Column(children: [
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: usernameController,
                builder: (context, TextEditingValue value, __) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Nutzername",
                        border: const OutlineInputBorder(),
                        errorText: Utils.checkIfEmpty(usernameController),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: passwordController,
                builder: (context, TextEditingValue value, __) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Passwort",
                        border: const OutlineInputBorder(),
                        errorText: Utils.checkIfEmpty(passwordController),
                      ),
                    ),
                  );
                },
              ),
            ),
            errorText == null
                ? const SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.red,
                    child: SelectableText(
                      errorText!,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
            Flexible(
              child: ElevatedButton.icon(
                onPressed: () => db.login(
                  usernameController.text,
                  passwordController.text,
                  loginCallback,
                ),
                icon: const Icon(Icons.login),
                label: const SelectableText("Einloggen"),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
