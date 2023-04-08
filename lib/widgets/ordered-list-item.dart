import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderedListItem extends StatelessWidget {
  final String imageAsset;
  final String textLabel;
  final VoidCallback callback;

  const OrderedListItem({Key? key, required this.imageAsset, required this.textLabel, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              "assets/images/$imageAsset",
              width: 25,
            ),
          ),
          Expanded(child: Text(textLabel)),
          Icon(
            Icons.navigate_next,
            color: Colors.orange[700],
          )
        ],
      ),
      onTap: callback,
    );
  }
}