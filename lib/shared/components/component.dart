import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icons_broken.dart';

String uid = '';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  required validate,
  required TextInputType type,
  required context,
  suffix,
  pressedShow,
  onTap,
  onSubmit,
  onChange,
  bool isPassword = false,
}) =>
    SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        decoration: InputDecoration(
          label: Text(label,
          style: Theme.of(context).textTheme.caption!.copyWith(
            fontSize: 16,
          ),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(
                  icon: suffix,
                  onPressed: pressedShow,
                )
              : null,
          border: const OutlineInputBorder(
          ),
          labelStyle: Theme.of(context).textTheme.bodyText1,
          prefixIconColor: Colors.blue,
        ),
        validator: validate,
        keyboardType: type,
        textAlignVertical: TextAlignVertical.top,
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(title!),
      actions: actions,
    );

Widget defaultButton({
  required onPressed,
  required String text,
  bool toUpperCase = false,
}) =>
    Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );

Future navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Future navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Future<bool?> toast({
  required String message,
  required ToastStates data,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(data),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastColor(ToastStates data) {
  Color color;
  switch (data) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
