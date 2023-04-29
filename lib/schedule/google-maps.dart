import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({Key? key}) : super(key: key);
@override
  State<ViewMap> createState() => _ViewMapState();
}
class _ViewMapState extends State<ViewMap> {
  late final GoogleMapController _controller;
  LatLng intialLocation = const LatLng(23.762912, 90.427816);
  LatLng marker1 = const LatLng(23.763912, 90.428816);

  LatLng intialLocation2 = const LatLng(23.772912, 90.428816);
  LatLng marker2 = const LatLng(23.770912, 90.428916);

  LatLng intialLocation3 = const LatLng(23.776912, 90.422816);
  LatLng marker3 = const LatLng(23.776918, 90.422823);
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'View on Maps',
          ),
        ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: intialLocation,
                zoom: 15.6746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.animateCamera(CameraUpdate.newLatLng(
                  const LatLng(56.1725505, 10.1850512),
                  ),);
              },
              markers: {
                Marker(
                  markerId: const MarkerId("1"),
                  position: marker1,
                  infoWindow: const InfoWindow(
                    title: 'Prashant Mohite',
                    snippet: 'Officer ID - A2344\nContact - 9764689923'
                  )
                ),
                Marker(
                  markerId: const MarkerId("2"),
                  position: marker2,
                  infoWindow: const InfoWindow(
                    title: 'Dilip Shinde',
                    snippet: 'Officer ID - H4583\nContact - 94562884892'
                  )
                ),
                Marker(
                  markerId: const MarkerId("3"),
                  position: marker3,
                  infoWindow: const InfoWindow(
                    title: 'Saurav Shetty',
                    snippet: 'Officer ID - A873\nContact - 867287764648'
                  )
                ),
              },
              circles: {
                Circle(
                  circleId: const CircleId("1"),
                  center: intialLocation,
                  radius: 300,
                  strokeWidth: 2,
                  fillColor: const Color(0xFF006491).withOpacity(0.2),
                ),
                Circle(
                  circleId: const CircleId("2"),
                  center: intialLocation2,
                  radius: 300,
                  strokeWidth: 2,
                  fillColor: const Color.fromARGB(255, 145, 82, 0).withOpacity(0.2),
                ),
                Circle(
                  circleId: const CircleId("3"),
                  center: intialLocation3,
                  radius: 300,
                  strokeWidth: 2,
                  fillColor: const Color.fromARGB(255, 0, 145, 2).withOpacity(0.2),
                ),
              },
              // ToDo: Add Circle
              // ToDo: Add polygon
            ),
          ),
        ],
      ),
    );
  }
}