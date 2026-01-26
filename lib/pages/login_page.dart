import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:trachat_app/widgets/rounded_button.dart';

//Widgets
import '../widgets/custom_input_field.dart';

//provider
import '../provider/authenticator_provider.dart';

//Services
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticatorProvider>(
      context,
    ); // ← Get here, don't store
    final navigation = GetIt.instance.get<NavigationService>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        height: MediaQuery.of(context).size.height * 0.98,
        width: MediaQuery.of(context).size.width * 0.97,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TraChat',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  CustomTextFormField(
                    controller: emailCtr,
                    hintText: "Email",
                    regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    requiredMessage: "Email is required",
                    invalidMessage: "Invalid email",
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: passwordCtr,
                    hintText: "Password",
                    isPassword: true,
                    regEx: r'^.{6,}$',
                    requiredMessage: "Password is required",
                    invalidMessage: "Minimum 6 characters",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RoundedButton(
                name: "Login",
                height: MediaQuery.of(context).size.height * 0.065,
                width: MediaQuery.of(context).size.width * 0.65,
                onPressed: () {
                  if (_loginFormKey.currentState!.validate()) {
                    // Use controllers directly - SIMPLER!
                    auth.login(emailCtr.text.trim(), passwordCtr.text);

                    // Optional: Clear after login attempt
                    // passwordCtr.clear();
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Register new account?",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
