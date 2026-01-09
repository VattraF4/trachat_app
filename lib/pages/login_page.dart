import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  // Widget _buildUI() => Scaffold(); //Same
  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_pageTitle(), _loginForm()],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    final double deviceHeight = MediaQuery.of(context).size.height;
    // print("_deviceHeight = $deviceHeight");

    return Container(
      height: deviceHeight * 0.1, // 10% of screen height
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center, // center text vertically & horizontally
      // color: Colors.blue, // optional background
      child: Text(
        'TraChat',
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {},
              regEx:
                  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$', // RegEx for Email
              hintText: "Input Email",
              obscureText: false,
            ),

            CustomTextFormField(
              onSaved: (value) {},
              regEx: r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\W]{8,}$', // 8+ chars, 1 upper, 1 lower, 1 digit
              hintText: "Password",
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
