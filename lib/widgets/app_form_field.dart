import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(),
    );

    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        hintText: hintText,
      ),
    );
  }
}
