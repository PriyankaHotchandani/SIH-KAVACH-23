import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert' show utf8;
import 'dart:io';

class ConnectBulkNFC extends StatefulWidget {
  const ConnectBulkNFC({Key? key}) : super(key: key);

  @override
  State<ConnectBulkNFC> createState() => _ConnectBulkNFCState();
}

/// Global flag if NFC is avalible
bool isNfcAvalible = false;

class _ConnectBulkNFCState extends State<ConnectBulkNFC> {
  bool listenerRunning = false;
  bool writeCounterOnNextContact = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      isNfcAvalible = await NfcManager.instance.isAvailable();
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
              // final ndefRecord = NdefRecord.createText(myController.text);
              final ndefRecord = NdefRecord.createText("Officer ID: A1244\n\nName: Prashant Mohite\n\nStation:Navpada Police Station\n\nContact: 93453843445");
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

// This widget is the root
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    return Scaffold(
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
                child: const Text("Officer ID: A1244\n\nName: Prashant Mohite\n\nStation:Navpada Police Station\n\nContact: 93453843445",
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Row(
                children: <Widget>[
                ElevatedButton(
                    onPressed: _writeNfcTag,
                    style: ElevatedButton.styleFrom(
                    primary: Colors.red),
                    child: const Text(
                      "Write NFC Tag",
                    ),
                    ),
                    const SizedBox(
                      width: 30
                    ),
                ElevatedButton(
                  onPressed: _listenForNFCEvents,
                  child: const Text("Read Tag"),
                  ),
                ],
              ),
              ),

            ], //<Widget>[]
          ), //Column
        ), //Center
      // ),
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