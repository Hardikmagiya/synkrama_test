import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget heightBox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget widthBox(double width) {
  return SizedBox(
    width: width,
  );
}

void showMessage({String? message, Color? messageColor}) =>
    Fluttertoast.showToast(msg: message ?? '',
        backgroundColor: messageColor ?? Colors.red,
        gravity: ToastGravity.TOP);


Widget commonButton({GestureTapCallback? onTap,String? text,Color? backgroundColor,Color? textColor}){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(color: backgroundColor ?? Colors.blue, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4), spreadRadius: 2)]),
      child: Center(
        child: Text(
          text ?? '',
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}