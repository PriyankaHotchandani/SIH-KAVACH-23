import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuickReportItem extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback callback;

  QuickReportItem({super.key, required this.image, required this.text,required this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/$image",
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ],
          ),
        ),
        onTap: callback,
      ),
    );
  }
}