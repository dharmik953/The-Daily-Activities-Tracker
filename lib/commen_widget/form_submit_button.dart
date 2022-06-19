import 'package:flutter/cupertino.dart';

import 'commen_Raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends commen_Raised_button{
  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
}) : super(child: Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
  ),
  height: 44.0,
  color: Colors.indigo,
    borderRadius: 4.0,
    onPressed: onPressed,
  );

}