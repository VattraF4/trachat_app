import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String regEx;
  final bool isPassword;
  final String requiredMessage;
  final String invalidMessage;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.regEx,
    required this.requiredMessage,
    required this.invalidMessage,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      // keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return widget.requiredMessage;
        }
        if (!RegExp(widget.regEx).hasMatch(value)) {
          return widget.invalidMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 160, 157, 157)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
