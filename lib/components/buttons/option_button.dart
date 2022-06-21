import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? color;
  final Color? textColor;
  const OptionButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color = Colors.blue,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Ink(
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        )),
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
