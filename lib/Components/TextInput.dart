import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Color backgroundColor;
  final Color iconColor;
  final Color placeholderColor;
  final Key? key;

  CustomInputField({
    required this.icon,
    required this.hintText,
    required this.backgroundColor,
    required this.iconColor,
    required this.placeholderColor,
    this.key, // Initialize the key parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, -7), // Move shadow up
            blurRadius: 5,
            spreadRadius: 1, // Spread radius is negative for inner shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: placeholderColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
