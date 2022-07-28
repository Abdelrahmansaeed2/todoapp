import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onClick;



  const Button({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    required this.onClick,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 285),
      child: Container(
        width: screenSize.width/1.2,
        height: 50,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: MaterialButton(

          color: Colors.green,
          onPressed: () {
            onClick();

          },
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}