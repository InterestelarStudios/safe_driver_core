// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoServices {

  Future<Localization>? getLocalizationFromWidget(BuildContext context,
      {LatLng? initialPosition, required String mapStyle}) async {
    Localization? localization = Localization();
    await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return GetGeoLocationScreen(
            onChanged: (value) {
              localization = value;
            },
            initialPosition: initialPosition,
            mapStyle: mapStyle,
          );
        });
    return localization!;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

class Localization {
  LatLng? latLng;
  String? address;
  Placemark? placemark;
  int? totalDistance;

  Localization({
    this.latLng,
    this.address,
    this.placemark,
    this.totalDistance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latLng': latLng!.toJson(),
      'address': address,
      'placemark': placemark!.toJson(),
      'totalDistance': totalDistance,
    };
  }

  factory Localization.fromMap(Map<String, dynamic> map) {
    return Localization(
      latLng: map['latLng'] != null ? LatLng.fromJson(map['latLng']) : null,
      address: map['address'] != null ? map['address'] as String : null,
      placemark: map['placemark'] != null ? Placemark.fromMap(map['placemark'] as Map<String,dynamic>) : null,
      totalDistance: map['totalDistance'] != null ? map['totalDistance'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Localization.fromJson(String source) => Localization.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GetGeoLocationScreen extends StatefulWidget {
  const GetGeoLocationScreen(
      {super.key, required this.onChanged, this.initialPosition, required this.mapStyle});
  final ValueChanged<Localization> onChanged;
  final LatLng? initialPosition;
  final String mapStyle;

  @override
  State<GetGeoLocationScreen> createState() => _GetGeoLocationScreenState();
}

class _GetGeoLocationScreenState extends State<GetGeoLocationScreen> {
  Location? location;
  String error = '';
  late GoogleMapController _mapController;
  Set<Marker> markers = {};
  //String _darkMapStyle = '';
  Placemark? placemark;
  final TextEditingController controllerAddress = TextEditingController();
  bool loading = false;

  getPosition() async {
    //await _loadMapStyles();
    try {
      if (widget.initialPosition != null) {
        location = Location(
            latitude: widget.initialPosition!.latitude,
            longitude: widget.initialPosition!.longitude,
            timestamp: DateTime.now());
      } else {
        Position position = await GeoServices().determinePosition();
        location = Location(
            latitude: position.latitude,
            longitude: position.longitude,
            timestamp: DateTime.now());
      }

      List<Placemark> placemarks = await placemarkFromCoordinates(
          location!.latitude, location!.longitude);
      placemark = placemarks[0];
      controllerAddress.text =
          '${placemark!.street}, ${placemark!.name} - ${placemark!.subLocality}, ${placemark!.subAdministrativeArea} - ${placemark!.administrativeArea}, ${placemark!.postalCode}';
      setState(() {
        markers.add(
          Marker(
            markerId: const MarkerId('Position'),
            position: LatLng(location!.latitude, location!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
          ),
        );
        location;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  /*Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/dark_mode_style.json');
  }*/

  /*@override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }*/

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  setPosition(String text) async {
    if (text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Digite mais detalhes sobre o endereço'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent[700]));
    } else {
      try {
        setState(() {
          loading = true;
        });
        List<Location> locations =
            await locationFromAddress(controllerAddress.text);
        location = locations[0];
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location!.latitude, location!.longitude);
        placemark = placemarks[0];
        controllerAddress.text =
            '${placemark!.street}, ${placemark!.name} - ${placemark!.subLocality}, ${placemark!.subAdministrativeArea} - ${placemark!.administrativeArea}, ${placemark!.postalCode}';
        setState(() {
          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId('Position'),
              position: LatLng(location!.latitude, location!.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            ),
          );
          _mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(location!.latitude, location!.longitude),
                  zoom: 14)));
          location;
          loading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Não foi possível localizar o endereço.'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.redAccent[700]));
      }
    }
  }

  setPositionOnTouch(LatLng latLng) async {
    setState(() {
      loading = true;
    });
    location = Location(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        timestamp: DateTime.now());
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location!.latitude, location!.longitude);
    placemark = placemarks[0];
    controllerAddress.text =
        '${placemark!.street}, ${placemark!.name} - ${placemark!.subLocality}, ${placemark!.subAdministrativeArea} - ${placemark!.administrativeArea}, ${placemark!.postalCode}';
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('Position'),
          position: LatLng(location!.latitude, location!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
        ),
      );
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(location!.latitude, location!.longitude),
              zoom: 17)));
      location;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: location == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error.isNotEmpty
              ? Center(
                  child: Text(error),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      markers: markers,
                      mapToolbarEnabled: false,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      style: widget.mapStyle,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(location!.latitude, location!.longitude),
                        zoom: 14,
                      ),
                      onTap: (argument) {
                        setPositionOnTouch(argument);
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                        /*if (Theme.of(context).brightness == Brightness.dark) {
                          _mapController.setMapStyle(_darkMapStyle);
                        }*/
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          margin: const EdgeInsets.only(
                              top: 100, left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: controllerAddress,
                              textCapitalization: TextCapitalization.words,
                              onEditingComplete: () {
                                setPosition(controllerAddress.text);
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search_rounded),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          controllerAddress.clear();
                                        },
                                        child: const Icon(Icons.close_rounded, color: Colors.grey,),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setPosition(controllerAddress.text);
                                      },
                                      child: const Icon(Icons.send_rounded),
                                    ),
                                  ],
                                ),
                                hintText: 'Digite o endereço...',
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                            ),
                          ),
                        ),
                        loading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: LinearProgressIndicator(),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const Card(
                      margin: EdgeInsets.only(top: 160, left: 10, right: 10),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'No mapa, toque no lugar que deseja para selecionar a localização ou insira o endereço no campo acima.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onChanged.call(
                              Localization(
                                  latLng: LatLng(location!.latitude,
                                      location!.longitude),
                                  placemark: placemark,
                                  address: controllerAddress.text),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Confirmar Localização')),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: SafeArea(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                            onPressed: ()=> Navigator.pop(context),
                            backgroundColor: Theme.of(context).cardTheme.color,
                            child: const Icon(Icons.close_rounded,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}