
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_app/commen_widget/commen_Raised_button.dart';

class social_sign_in_button extends commen_Raised_button{
  social_sign_in_button({
    required String assestname,
    required String text,
    required Color color,
    required Color textcolor,
    required VoidCallback onPressed,
  }) : assert(text != null),
       assert(assestname != null),
        super(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(assestname),
      Text(text,
        style : TextStyle(color: textcolor, fontSize: 15,),
      ),
      Opacity(
          opacity : 0.0,
          child: Image.asset(assestname)),
    ],
    ),
    color: color,
    onPressed: onPressed,
    borderRadius: 4.0,
  );
}