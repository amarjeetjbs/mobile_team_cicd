import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool termAndConditionSelected = false;
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void termAndConditionSelection(bool? value) {
    setState(() {
      termAndConditionSelected = (value ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey("emailField"),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.isValidEmail()) {
                    return "Check your email";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                key: const ValueKey("passwordField"),
                controller: passwordController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be length 8 letter/digit';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                value: termAndConditionSelected,
                onChanged: termAndConditionSelection,
                title: const Text("Accept term and condition"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                key: const ValueKey<String>("LoginBtn"),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  await Future.delayed(const Duration(microseconds: 900));

                  if (_formKey.currentState!.validate()) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    MediaQuery.of(context).size.width,
                    55,
                  ),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
