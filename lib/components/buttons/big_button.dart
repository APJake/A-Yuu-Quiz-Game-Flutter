import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Color? color;
  const BigButton(
      {Key? key,
      required this.child,
      required this.onTap,
      this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Ink(
        child: Center(child: child),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
