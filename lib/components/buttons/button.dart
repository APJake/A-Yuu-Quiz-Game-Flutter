import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final bool isLoading;
  final Function onTap;
  final double width;

  const Button(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color = Colors.black,
      this.backgroundColor = Colors.blue,
      this.isLoading = false,
      this.icon,
      this.width = double.infinity})
      : super(key: key);

  _button() => InkWell(
        onTap: () => onTap(),
        child: Ink(
          child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: color,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(icon!))
                            : Container(),
                        Text(
                          text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: color),
                        )
                      ],
                    )),
          width: width,
          height: 50,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(14))),
        ),
        borderRadius: BorderRadius.circular(14),
      );

  @override
  Widget build(BuildContext context) {
    return _button();
  }
}
