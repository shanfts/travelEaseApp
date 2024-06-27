import 'package:flutter/material.dart';

// Update CustomButton to use void Function()? for onPressed
class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.buttonText,
    this.onPressed, // Make onPressed optional
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        height: 60,
        child: MaterialButton(
          textColor: Colors.white,
          color: const Color(0xFF0B274E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Text(
            buttonText, // Ensure this is never null
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: onPressed, // Allow null for onPressed
        ),
      ),
    );
  }
}
