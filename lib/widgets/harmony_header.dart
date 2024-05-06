import 'package:flutter/material.dart'; 
class harmonyHeader extends StatelessWidget {
  const harmonyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          Expanded(
            flex: 2,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Harm',
                  style: new TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'ony',
                  style: new TextStyle(
                      fontSize: 28.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}