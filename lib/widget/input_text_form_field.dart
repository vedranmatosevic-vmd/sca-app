import 'package:flutter/material.dart';

/// Custom text form field
class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    Key? key,
    this.isPhoneNumber = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    this.controller,
    required this.value
  }) : super(key: key);

  final String value;
  final bool isPhoneNumber;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: controller,
        keyboardType: isPhoneNumber ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38
              )
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black
              )
          ),
          labelText: value,
          contentPadding: const EdgeInsets.all(0),
          labelStyle: const TextStyle(
            color: Colors.black38,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
