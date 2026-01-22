import 'package:flutter/material.dart';
import 'package:trachat_app/widgets/rounded_button.dart';

//Widgets
import '../widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

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
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.08,
          vertical: _deviceHeight * 0.05,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pageTitle(),
              const SizedBox(height: 40),
              _loginForm(),
              const SizedBox(height: 20),
              _loginButton(),
              const SizedBox(height: 20),
              _registerAccountLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      'TraChat',
      style: TextStyle(
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _loginForm() {
    return Column(
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
        const SizedBox(height: 30),
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       if (_loginFormKey.currentState!.validate()) {
        //         print(emailCtr.text);
        //         print(passwordCtr.text);
        //       }
        //     },
        //     child: const Text("Login"),
        //   ),
        // ),
      ],
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Login",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () {},
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        child: Text(
          "Register new account?",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}