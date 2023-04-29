import 'package:flutter/material.dart';

class ConnectBulkNFC extends StatelessWidget {
  const ConnectBulkNFC({Key? key}) : super(key: key);
 
// This widget is the root
// of your application
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Connect to NFC Tags',
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Ready to Scan',
                  style: TextStyle(color: Colors.grey,fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset('assets/images/connect-tag.jpg',
                  height: 300,
                  scale: 2.5,),

              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Approach the NFC Tag',
                  style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              
            ], //<Widget>[]
          ), //Column
        ), //Center
      ),
    );
  }
}