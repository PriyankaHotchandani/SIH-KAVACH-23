import 'package:flutter/material.dart';
import 'package:nfc_counter/schedule/record-initial-location.dart';

class ConnectBulkNFC2 extends StatelessWidget {
  const ConnectBulkNFC2({Key? key}) : super(key: key);
 
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
                height: 10,
              ),
              const Center(
                child: Text(
                  'Approach the NFC Tag',
                  style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                height: 140,
                width: double.infinity,
                //color: const Color.fromARGB(255, 194, 192, 192),
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 228, 228),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: const Text("Officer ID: A873\n\nName: Saurav Shetty\n\nStation:Navpada Police Station\n\nContact: 859788347",
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                children: <Widget>[
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                    primary: Colors.red),
                    child: const Text(
                      "Write NFC Tag",
                    ),
                    ),
                    const SizedBox(
                      width: 20
                    ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Read Tag"),
                  ),
                  const SizedBox(
                      width: 20
                    ),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RecordLocation()));},
                  child: const Text("Next"),
                  ),
                ],
              ),
              ),
              
            ], //<Widget>[]
          ), //Column
        ), //Center
      ),
    );
  }
}