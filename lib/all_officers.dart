import 'package:flutter/material.dart';
import 'package:nfc_counter/dashboard.dart';
import 'package:nfc_counter/homescreen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc_counter/officer-detail.dart';


class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}

class AllOfficers extends StatefulWidget {
  const AllOfficers({Key? key}) : super(key: key);

  @override
  _AllOfficerState createState() => _AllOfficerState();
}

class _AllOfficerState extends State<AllOfficers> {
  late List data;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Officers details"),
      ),
      body: Container(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('assets/json/officers.json'),
            builder: (BuildContext context, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Text('no data');
                } else {
                  var newData = json.decode(snapshot.data.toString());
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            newData[index]['image']
                          ),
                        ),
                        title: Text(newData[index]['firstName'] +" "+ newData[index]['lastName']),
                        subtitle: Text("Officer ID: " + newData[index]['password']),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: (){

                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailPage(newData[index]['password'],(newData[index]['firstName'] + newData[index]['lastName']),newData[index]['image'],newData[index]['email'],newData[index]['phone'],newData[index]['address'],newData[index]['birthDate'],newData[index]['gender']))
                          );

                        },
                      );
                    },
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Text('Error'); // error
              } else {
                  return Container(
                    child: const Center(
                      child: Text("Loading...")
                    )
                  );
              }
              // if(snapshot.data == null){
              //   return Container(
              //     child: const Center(
              //       child: Text("Loading...")
              //     )
              //   );
              // } else {
              //   return ListView.builder(
              //     itemBuilder: (BuildContext context, int index) {
              //       return ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage: NetworkImage(
              //             newData[index]['picture']
              //           ),
              //         ),
              //         title: Text(newData[index]['name']),
              //         subtitle: Text(newData[index]['email']),
              //         onTap: (){

              //           Navigator.push(context, 
              //             MaterialPageRoute(builder: (context) => DetailPage(newData[index]))
              //           );

              //         },
              //       );
              //     },
              //   );
              // }
            },
          ),
        ),
      );
  }

  
}
