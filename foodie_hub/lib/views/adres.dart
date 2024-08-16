import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Adres extends StatefulWidget {
  const Adres({super.key});

  @override
  State<Adres> createState() => _AdresState();
}

class _AdresState extends State<Adres> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = const LatLng(38.6817, 39.2194); // Elazığ konumu
  String adres = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Adres Seçici',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange ,Colors.orangeAccent], // Gradient renkleri
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                print('Harita yüklendi');
              },
              onTap: _onMapTapped,
              markers: {
                Marker(
                  markerId: const MarkerId("selected_location"),
                  position: _selectedLocation,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Seçilen Adres: $adres"),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange
              ),
              onPressed: () {
                // Adresi kaydetme işlevini burada tanımlayabilirsiniz.
                Navigator.pop(context, adres); // Adres bilgisini döndür
              },
              child: const Text("Kaydet", style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onMapTapped(LatLng position) async {
    setState(() {
      _selectedLocation = position;
    });

    // Adresi al
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        adres = "${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].country}";
      });
    }
  }
}


//AIzaSyBp5UVsPdkrRooFSVS2n579RCKNXMV4xkQ