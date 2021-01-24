import 'package:flutter/material.dart';

class DesignInputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;

  const DesignInputField(
      {@required this.hint, @required this.controller, this.obscure = false,});

  @override
  _DesignInputFieldState createState() => _DesignInputFieldState();
}

class _DesignInputFieldState extends State<DesignInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        enabled: true,
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: Colors.black38,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        enabledBorder: inputBorder,
        errorBorder: inputBorder.copyWith(borderSide: BorderSide(color: Colors.red)),
        focusedBorder: inputBorder,
        disabledBorder: inputBorder,
        border: inputBorder,
      ),
    );
  }

  InputBorder inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(width: 1.0, color: Colors.black54),
  );
}
