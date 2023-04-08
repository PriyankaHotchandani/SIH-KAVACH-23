import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MiscListItem extends StatelessWidget {
  final String title;
  final String message;
  final String actionLabel;
  final Color actionButtonColor;
  final VoidCallback onclick;

  const MiscListItem({Key? key, required this.title, required this.message, required this.actionLabel, required this.actionButtonColor, required this.onclick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.only(top:0, left:2.0, right: 8),
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: onclick,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(color: actionButtonColor, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}