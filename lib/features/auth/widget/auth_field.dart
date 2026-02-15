import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscureText = false;
  bool _isPasswordField = false;

  @override
  void initState() {
    super.initState();
    _isPasswordField = widget.hintText.toLowerCase().contains('password');
    _obscureText = _isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Pallete.blueColor, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Pallete.greyColor),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 18),
        suffixIcon: _isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Pallete.greyColor,
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
