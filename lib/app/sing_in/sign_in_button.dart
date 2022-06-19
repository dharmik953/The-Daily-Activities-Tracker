
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_app/commen_widget/commen_Raised_button.dart';

class Sign_in_button extends commen_Raised_button{
  Sign_in_button({
    required String text,
    required Color color,
    required Color textcolor,
    required VoidCallback onPressed,
  }) :  assert(text != null),
        super(
        child: Text(
          text,
          style : TextStyle(color: textcolor, fontSize: 15,),
      ),
            color: color,
            onPressed: onPressed,
            borderRadius: 4.0,
    );
}