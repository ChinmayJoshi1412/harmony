import 'package:flutter/material.dart';
class RowButtons extends StatelessWidget {
  final String buttonName;
  final IconData icon;
  final Function()? onPressed;
  const RowButtons({
    super.key,
    required this.buttonName,
    required this.icon,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: IconButton(
              icon: new Icon(icon),
              onPressed: onPressed,
              iconSize: 30.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(buttonName, style: TextStyle(color: Colors.black45)),
          ),
        ],
      ),
    );
  }
}