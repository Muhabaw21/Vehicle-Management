import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

bool _isElevated = false;

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[320],
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isElevated = !_isElevated;
            });
          },
          child: AnimatedContainer(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
                boxShadow: _isElevated
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                          // inset:isPressed,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : null),
            duration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}
