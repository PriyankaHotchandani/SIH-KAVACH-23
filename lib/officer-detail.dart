import 'package:flutter/material.dart';

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);

}

class DetailPage extends StatelessWidget {

  final String name;
  final String image;
  final String id;
  final String email;
  final String phone;
  final String birthday;
  final String gender;
  final Object address;

  const DetailPage(this.id,this.name,this.image,this.email,this.phone,this.address,this.birthday,this.gender,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(height: 10),
          const Text(
            'Username',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Bio',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}