import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}

class DetailPage extends StatefulWidget {
  final String name;
  final String image;
  final String id;
  final String email;
  final String phone;
  final String birthday;
  final String gender;
  final Object address;

  const DetailPage(this.id, this.name, this.image, this.email, this.phone,
      this.address, this.birthday, this.gender,
      {super.key});

  @override
  State<DetailPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailPage> {
  late List<dynamic>? _data = [null];
  int _counter = 0;
  Future<void> _loadData() async {
    var contents = await rootBundle.loadString('assets/json/officers.json');
    setState(() {
      _data = json.decode(contents);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data?[0] == null) {
      return const Center(child: CircularProgressIndicator());
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      title: 'Profile Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://robohash.org/hicveldicta.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                _data?[0]['firstName'] ?? '',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Software Engineer',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 10.0),
                  Text(
                    'Kamal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.phone),
                  SizedBox(width: 10.0),
                  Text(
                    '+1 123-456-7890',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
