// ignore_for_file: unused_import, non_constant_identifier_names

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:path/path.dart';
import 'package:tbib_toast/tbib_toast.dart';

Widget mytext({
  required String text,
  double? fontsize,
  FontWeight? weight,
  double? height,
  int? maxlines,
  TextOverflow? overflow,
}) =>
    Text(
      text,
      maxLines: maxlines,
      style: TextStyle(
        height: height ?? 1,
        color: Colors.black,
        fontSize: fontsize ?? 14,
        fontWeight: weight ?? FontWeight.normal,
        overflow: overflow,
      ),
    );

Widget defaultButtom({
  double width = double.infinity,
  Color background = Colors.black,
  double radius = 30,
  required Function onpress,
  required String text,
  Color bottomcolor = defaultColor,
}) =>
    Container(
      decoration: BoxDecoration(
          color: bottomcolor, borderRadius: BorderRadius.circular(radius)),
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget defaultFormField({
  TextEditingController? controller,
  String? labelText,
  Function? validate,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  TextInputType? type,
  bool isPass = false,
  Function? suffixpressed,
  bool isclickable = true,
}) =>
    TextFormField(
      obscureText: isPass ? true : false,
      controller: controller,
      enabled: isclickable,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            if (suffixIcon != null) {
              suffixpressed!();
            } else {
              {}
            }
          },
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) => validate!(value),
      onChanged: (value) => onChange!(value),
      onFieldSubmitted: (value) => onSubmit!(value),
      onTap: () => onTap!(),
      keyboardType: type,
    );

void NavigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NavigateToreplace(context, Widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Widget));

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

void showToast({
  context,
  required String t,
  required ToastStates state,
}) =>
    Toast.show(t, context, backgroundColor: chooseToastColor(state));


Widget emailverification() {
  return Container(
    height: 50,
    color: Colors.amber,
    child: Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Icon(Icons.info_outline),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Text(
          '  please verify your email',
          style: TextStyle(color: Colors.black),
        )),
        defaultButtom(
          width: 80,
          bottomcolor: Colors.transparent,
          onpress: () {
            FirebaseAuth.instance.currentUser!
                .sendEmailVerification()
                .then((value) {
              showToast(
                  context: context,
                  t: 'Check your Email',
                  state: ToastStates.SUCCESS);
            }).catchError((error) {
              print(error.toString());
            });
          },
          text: 'send',
        ),
      ],
    ),
  );
}
          //   (!FirebaseAuth.instance.currentUser!.emailVerified)
          //        },
          // ),   return if