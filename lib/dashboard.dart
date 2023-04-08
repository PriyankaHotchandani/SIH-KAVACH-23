import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(Icons.menu, color: Colors.blue,size: 52.0,),
                  Image.asset("assets/image.png",width: 52.0,)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Welcome to NFC Asset Tracker \nSelect an option",
                style: TextStyle(
                  color: Colors.blue,
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

                        color: const Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            children: <Widget>[
                              Image.asset("assets/todo.png",width: 64.0,),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "Todo List",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Text(
                                "2 Items",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100
                                ),
                              )
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

                        color: const Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/note.png",width: 64.0,),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    "Notes",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    "12 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100
                                    ),
                                  )
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

                        color: const Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/calendar.png",width: 64.0,),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    "Agenda",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    "4 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100
                                    ),
                                  )
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

                        color: const Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/settings.png",width: 64.0,),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    "6 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100
                                    ),
                                  )
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