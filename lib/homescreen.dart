// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nfc_counter/dashboard.dart';
import 'package:nfc_counter/widgets/quick-report-item.dart';
import 'package:nfc_counter/widgets/misc-list-item.dart';
import 'package:nfc_counter/widgets/ordered-list-item.dart';
import 'package:nfc_counter/utils/widget-utils.dart';
import 'package:nfc_counter/all_officers.dart';
import 'package:nfc_counter/schedule/create-duty.dart';
import 'package:nfc_counter/schedule/google-maps.dart';
import 'package:nfc_counter/schedule/record-initial-location.dart';
import 'package:nfc_counter/schedule/test/connecting-nfc-officer2.dart';
class Choice {
  const Choice({required this.title, required this.icon, required this.route});

  final String title;
  final IconData icon;
  final String route;
}

class Category {
  const Category(
      {required this.title, required this.description, required this.color});

  final String title;
  final String description;
  final Color color;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'ACCOUNT', icon: Icons.account_circle, route: ""),
  Choice(title: 'REPORT HISTORY', icon: Icons.history, route: ""),
  Choice(title: 'SETTING', icon: Icons.settings, route: ""),
  Choice(title: 'FEEDBACK', icon: Icons.feedback, route: ""),
  Choice(title: 'PRIVACY/TERMS', icon: Icons.verified_user, route: ""),
];

const List<Category> allCategories = <Category>[];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Color.fromARGB(255, 3, 3, 3)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset("assets/images/citizen_app_logo.png"),
        ),
        backgroundColor: Colors.grey[50],
        // brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: (choice) {
              Navigator.pushNamed(context, choice.route);
            },
            icon: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 30,
            ),
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 2.0, left: 0.0, right: 8.0),
                        child: Icon(
                          choice.icon,
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 2.0, left: 2.0, right: 0.0),
                        child: Text(choice.title,
                            style: TextStyle(color: Colors.grey[700])),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _buildHeaderWidgets(
                    "NFC Module",
                    Image.asset(
                      "assets/nfc-sign-icon.png",
                      width: 80,
                    ),
                    Colors.red,
                    () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: _buildHeaderWidgets(
                    "Past Reports",
                    Image.asset(
                      "assets/images/send_report.png",
                      width: 80,
                    ),
                    Colors.indigo,
                    () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8.0, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Past Report"),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Divider(
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        QuickReportItem(
                          image: "policeman.png", // originally record_audio_1
                          text: "Officers",
                          callback: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return AllOfficers();
                              },
                            ));
                          },
                        ),
                        QuickReportItem(
                            image: "danger.png", //originally take_photo
                            text: "Alerts",
                            callback: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ViewMap();
                                },
                              ));
                            }),
                        QuickReportItem(
                          image: "calendar.png", // originally record_video
                          text: "Schedule",
                          callback: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CreateDuty();
                              },
                            ));
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8.0, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    OrderedListItem(
                      imageAsset: "emergency_lines.png",
                      textLabel: "Emergency Phone Lines",
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return RecordLocation();
                      },));
                      },
                    ),
                    Divider(),
                    OrderedListItem(
                      imageAsset: "locate_stations.png",
                      textLabel: "Locate Nearest Police Stations",
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ));
                      },
                    ),
                    Divider(),
                    OrderedListItem(
                      imageAsset: "past.png", // originally most_wanted
                      textLabel: "Past Bandobast duty details",
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ));
                      },
                    ),
                    Divider(),
                    OrderedListItem(
                      imageAsset:
                          "return-to-the-past.png", //originally missing_items
                      textLabel: "Previous Alerts",
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ));
                      },
                    ),
                    Divider(),
                    OrderedListItem(
                      imageAsset: "notices.png",
                      textLabel: "Notifications & Public Notices",
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ConnectBulkNFC2();
                          },
                        ));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, left: 8.0, right: 8),
              child: Row(
                children: allCategories.map((value) {
                  return MiscListItem(
                    title: value.title,
                    message: value.description,
                    actionButtonColor: value.color,
                    actionLabel: value.title,
                    onclick: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ));
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _optionsDialogBox(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildHeaderWidgets(
      String text, Image image, Color color, VoidCallback onclick) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: image,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: onclick,
      ),
    );
  }
}
