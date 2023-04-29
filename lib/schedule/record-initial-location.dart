import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:nfc_counter/schedule/google-maps.dart';
import 'package:nfc_counter/schedule/teamModel.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyA7Dfm5_owPuczra0Ey8TsE92PDf1-RC8s";
Map<String, dynamic> officer1 = {"title":"Prashant Mohite","snippet":"Officer ID - A1244\nContact - 9764689923"};
Map<String, dynamic> officer2 = {"title":"Dilip Shinde","snippet":"Officer ID - H4583\nContact - 94562884892"};
Map<String, dynamic> officer3 = {"title":"Saurav Shetty","snippet":"Officer ID - A873\nContact - 867287764648"};
List officer_info = [officer1, officer2, officer3];

List<TeamModel> contacts = [
     TeamModel("Prashant Mohite", "Officer ID: A1244", false),
     TeamModel("Dilip Shinde", "Officer ID: H4583", false),
     TeamModel("Saurav Shetty", "Officer ID: A873", false),
  ];

List<TeamModel> selectedContacts = [];

class RecordLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Record Initial Location", home: BspAddressmapscreen());
  }
}

class BspAddressmapscreen extends StatefulWidget {
  const BspAddressmapscreen({Key? key}) : super(key: key);

  @override
  _BspAddressmapscreenState createState() => _BspAddressmapscreenState();
}

class _BspAddressmapscreenState extends State<BspAddressmapscreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              /*NavigationHelper.navigatetoBack(context);*/
            }),
        centerTitle: true,
        title: const Text("Record Initial Location"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back_ios),
              label: const Text('Save'),
              onPressed: () {
                Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewMap()));
                //getUserLocation();
              },
            ),
            officerListView(),
          ],
        ),
      ),
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            _searchbar(),
          ],
        ),
      ),
    );
  }

  getUserLocation() async {
    markers.values.forEach((value) async {
      print(value.position);
      // From coordinates
      final coordinates =
           Coordinates(value.position.latitude, value.position.longitude);
      var addresses = await Geocoder.google(kGoogleApiKey)
          .findAddressesFromCoordinates(coordinates);

      print("Address: ${addresses}");

    });
  }


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            const CameraPosition(target: LatLng(23.762912, 90.427816), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
         _controller.animateCamera(CameraUpdate.newLatLng(
            const LatLng(23.762912, 90.427816),
          ),);
        },
        markers: Set<Marker>.of(markers.values),
        onLongPress: (LatLng latLng) {
          // creating a new MARKER
          var markerIdVal = markers.length + 1;
          String mar = markerIdVal.toString();
          final MarkerId markerId = MarkerId(mar);
          Map<String, dynamic> currentOfficer = officer_info[markers.length];
          final Marker marker = Marker(markerId: markerId, position: latLng,infoWindow: InfoWindow(
                    title: currentOfficer['title'],
                    snippet: currentOfficer['snippet']
                  ));

          setState(() {
            markers[markerId] = marker;
          });
        },
      ),
    );
  }

  Widget officerListView() {
    return Container(
      child:Expanded(
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
    );
  }
  Widget _searchbar() {
    return Positioned(
      top: 50.0,
      right: 15.0,
      left: 15.0,
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter Address',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              //onPressed: searchandNavigate,
              onPressed: () {},
              iconSize: 30.0,
            ),
          ),
          onChanged: (val) {
            setState(() {
              // searchAddr = val;
            });
          },
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
      trailing: !isSelected
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