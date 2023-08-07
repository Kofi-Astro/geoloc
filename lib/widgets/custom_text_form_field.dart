import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final double? verticalPadding;
  final String? value;
  final Icon? suffixIcon;
  final bool showLabel;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function? validatorFunction;
  final Function? onSavedFunction;
  final Function? onFieldSubmittedFunction;
  final Function? onChanged;
  final TextEditingController? controller;

  const CustomTextFormField({super.key, 
    this.controller,
    this.onFieldSubmittedFunction,
    this.onSavedFunction,
    this.validatorFunction,
    this.onChanged,
    required this.labelText,
    this.verticalPadding,
    this.value,
    this.suffixIcon,
    this.showLabel = true,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: controller,
            onSaved: onSavedFunction as void Function(String?)?,
            onFieldSubmitted:
                onFieldSubmittedFunction as void Function(String)?,
            onChanged: onChanged as void Function(String)?,
            validator: validatorFunction as String? Function(String?)?,
            obscureText: obscureText,
            keyboardType: keyboardType,
            initialValue: value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7),
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white.withOpacity(0.85),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
