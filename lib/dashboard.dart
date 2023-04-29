import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

/// Global flag if NFC is avalible

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NFC Configuration",
          style: TextStyle(color: Color.fromARGB(255, 252, 250, 250)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset("assets/nfc-sign-icon.png"),
        ),
        brightness: Brightness.light,
        elevation: 0,

      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Welcome to NFC Configurations \nSelect an option",
                style: TextStyle(
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing:20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: const Color.fromARGB(255, 209, 208, 208),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                            children: <Widget>[
                              Image.asset("assets/nfc-read-icon.png",width: 64.0,),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                "Start NFC Listener",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 37, 35, 35),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0
                                ),
                              ),
                              
                            ],
                            ),
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: const Color.fromARGB(255, 209, 208, 208),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/write-tag.png",width: 64.0,),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Write to Tag",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: const Color.fromARGB(255, 209, 208, 208),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/edit-metadata.png",width: 64.0,),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Metadata",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: const Color.fromARGB(255, 209, 208, 208),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/settings.png",width: 64.0,),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Info",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}