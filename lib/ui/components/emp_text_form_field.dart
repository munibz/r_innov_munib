import 'package:flutter/material.dart';

class EmpTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? showCursor;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function()? onTap;

  const EmpTextField(
      {super.key,
      this.label,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.onSaved,
      this.onTap,
      this.showCursor,
      this.readOnly,
      this.controller,
      this.initialValue,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onTap: onTap,
      initialValue: initialValue,
      showCursor: showCursor,
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            color: Colors.red.shade300,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
      ),
    );
  }
}
