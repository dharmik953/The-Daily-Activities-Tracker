import 'package:flutter/material.dart';

class commen_Raised_button extends StatelessWidget {
  commen_Raised_button({
    this.borderRadius: 2.0,
    required this.child,
    required this.color,
    required this.onPressed,
    this.height: 50.0,
  }) : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
