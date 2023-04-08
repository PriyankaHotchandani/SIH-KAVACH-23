import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:convert' show utf8;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

/// Global flag if NFC is avalible
bool isNfcAvalible = false;

class _DashboardState extends State<Dashboard> {
  bool listenerRunning = false;
  bool writeCounterOnNextContact = false;
  TextEditingController myController = TextEditingController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      isNfcAvalible = await NfcManager.instance.isAvailable();
    });
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _listenForNFCEvents() async {
    //Always run this for ios but only once for android
    if (Platform.isAndroid && listenerRunning == false || Platform.isIOS) {
      //Android supports reading nfc in the background, starting it one time is all we need
      if (Platform.isAndroid) {
        _alert(
          'NFC listener running in background now, approach tag(s)',
        );
        //Update button states
        setState(() {
          listenerRunning = true;
        });
      }

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          bool succses = false;
          //Try to convert the raw tag data to NDEF
          final ndefTag = Ndef.from(tag);
          //If the data could be converted we will get an object
          if (ndefTag != null) {
            // If we want to write the current counter value we will replace the current content on the tag
            if (writeCounterOnNextContact) {
              //Ensure the write flag is off again
              setState(() {
                writeCounterOnNextContact = false;
              });
              //Create a 1Well known tag with en as language code and 0x02 encoding for UTF8
              final ndefRecord = NdefRecord.createText(myController.text);
              //Create a new ndef message with a single record
              final ndefMessage = NdefMessage([ndefRecord]);
              //Write it to the tag, tag must still be "connected" to the device
              try {
                //Any existing content will be overwritten
                await ndefTag.write(ndefMessage);
                _alert('Data written to the tag successfully');
                // myController.text = "";
                succses = true;
              } catch (e) {
                _alert("Writing failed, press 'Write to tag' again");
              }
            }
            //The NDEF Message was already parsed, if any
            else if (ndefTag.cachedMessage != null) {
              var ndefMessage = ndefTag.cachedMessage!;

              //Each NDEF message can have multiple records, we will use the first one in our example
              if (ndefMessage.records.isNotEmpty &&
                  ndefMessage.records.first.typeNameFormat ==
                      NdefTypeNameFormat.nfcWellknown) {
                //If the first record exists as 1:Well-Known we consider this tag as having a value for us
                final wellKnownRecord = ndefMessage.records.first;

                ///Payload for a 1:Well Known text has the following format:
                ///[Encoding flag 0x02 is UTF8][ISO language code like en][content]

                if (wellKnownRecord.payload.first == 0x02) {
                  //Now we know the encoding is UTF8 and we can skip the first byte
                  final languageCodeAndContentBytes =
                  wellKnownRecord.payload.skip(1).toList();
                  //Note that the language code can be encoded in ASCI, if you need it be carfully with the endoding
                  final languageCodeAndContentText =
                  utf8.decode(languageCodeAndContentBytes);
                  //Cutting of the language code
                  final payload = languageCodeAndContentText.substring(2);
                  //Parsing the content to int
                  final storedCounters = payload.toString();
                  succses = true;
                  _alert(storedCounters);
                }
              }
            }
          }
          //Due to the way ios handles nfc we need to stop after each tag
          if (Platform.isIOS) {
            NfcManager.instance.stopSession();
          }
          if (succses == false) {
            _alert(
              'Tag was not valid',
            );
          }
        },
        // Required for iOS to define what type of tags should be noticed
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
      );
    }
  }

  void _alert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }

  void _writeNfcTag() {
    setState(() {
      writeCounterOnNextContact = true;
    });

    if (Platform.isAndroid) {
      _alert('Approach phone with tag');
    }
    //Writing a requires to read the tag first, on android this call might do nothing as the listner is already running
    _listenForNFCEvents();
  }

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
        child: SingleChildScrollView(
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
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              TextButton(
                child: Text("Get location"),
                onPressed: () async {
                await _getCurrentLocation();
                myController.text = "LAT: 19.175263, LNG: 72.9458786";
                _writeNfcTag();
                },
              ),
              if (_currentPosition != null) const Padding(
                padding: EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 0.0),
                child: Text(
                    // "LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"
                    "LAT: 19.175263, LNG: 72.9458786"
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: TextField(
              //     keyboardType: TextInputType.name,
              //     decoration: InputDecoration(labelText: 'Enter data in NFC'),
              //     controller: myController,
              //     onEditingComplete: () {
              //       _writeNfcTag();
              //       FocusManager.instance.primaryFocus?.unfocus();
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20.0,
                    children: <Widget>[
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Color.fromARGB(255, 209, 208, 208),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: _listenForNFCEvents,
                            // onTap: () {
                            //   print("tapped start nfc listener");
                            // },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/nfc-read-icon.png",
                                    width: 60.0,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Start NFC Listener",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Color.fromARGB(255, 209, 208, 208),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: _writeNfcTag,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/write-tag.png",
                                    width: 46.0,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Write to Tag",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Color.fromARGB(255, 209, 208, 208),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () {
                              _alert("Display data from the tag");
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/edit-metadata.png",
                                    width: 64.0,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Metadata",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Color.fromARGB(255, 209, 208, 208),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () {
                              print("Tapped Info");
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/settings.png",
                                    width: 64.0,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    "Info",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 37, 35, 35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    try {
      NfcManager.instance.stopSession();
    } catch (_) {
      //We dont care
    }
    super.dispose();
  }
}
