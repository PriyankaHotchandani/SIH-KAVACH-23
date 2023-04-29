import 'package:flutter/material.dart';
import 'package:nfc_counter/schedule/teamModel.dart';
import 'package:nfc_counter/schedule/connecting-nfc.dart';

class GroupSelect extends StatefulWidget {
  @override
  _GroupSelectState createState() => _GroupSelectState();
}

class _GroupSelectState extends State<GroupSelect> {
  List<TeamModel> contacts = [
     TeamModel("Central Brihanmumbai Team", "108 officers", false),
     TeamModel("Thane central Police team", "65 officers", false),
     TeamModel("Eastern wadala team", "28 officers", false),
     TeamModel("Bandobast duty team", "134 officers", false),
     TeamModel("Port zone team", "35 officers", false),
     TeamModel("Kalbadevi-Byculla Station", "60 officers", false),
     TeamModel("Goregaon-Malad Eastern Station", "50 officers", false),
     TeamModel("Testing duty Team","3 officers",false),
  ];

  List<TeamModel> selectedContacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select team of officers"),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ContactItem(
                        contacts[index].name,
                        contacts[index].phoneNumber,
                        contacts[index].isSelected,
                        index,
                      );
                    }),
              ),
              Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              const Text("Select Teams of Officers"),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                ),
              ]),
              
              selectedContacts.isNotEmpty ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Select (${selectedContacts.length})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return const ConnectBulkNFC();
                      },));
                    },
                  ),
                ),
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ContactItem(
      String name, String phoneNumber, bool isSelected, int index) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(phoneNumber),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          contacts[index].isSelected = !contacts[index].isSelected;
          if (contacts[index].isSelected == true) {
            selectedContacts.add(TeamModel(name, phoneNumber, true));
          } else if (contacts[index].isSelected == false) {
            selectedContacts
                .removeWhere((element) => element.name == contacts[index].name);
          }
        });
      },
    );
  }
}