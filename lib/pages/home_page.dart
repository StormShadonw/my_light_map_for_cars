import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_light_map_for_cars/controllers/home_controller.dart';
import 'package:my_light_map_for_cars/controllers/navigation_controller.dart';
import 'package:my_light_map_for_cars/utils/constants.dart';
import 'package:my_light_map_for_cars/widgets/bottom_bar.dart';
import 'package:my_light_map_for_cars/widgets/destination_box.dart';
import 'package:my_light_map_for_cars/widgets/directions_status_bar.dart';
import 'package:my_light_map_for_cars/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  Future<void> getInitData() async {}

  @override
  void initState() {
    // TODO: implement initState
    getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    var size = MediaQuery.of(context).size;
    Get.put(NavigationController());
    return Obx(() => Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  buildingsEnabled: false,
                  // cloudMapId: "71d6212673cb9822",
                  // liteModeEnabled: true,
                  style: '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
''',
                  trafficEnabled: false,
                  compassEnabled: false,
                  mapType: MapType.normal,

                  initialCameraPosition: homeController.initialCameraPosition,
                  myLocationEnabled:
                      homeController.mapStatus.value != Constants.onDestination,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,

                  markers: homeController.markers.values.toSet(),
                  polylines: Set<Polyline>.of(homeController.polyline),
                  onMapCreated: (GoogleMapController controller) async {
                    homeController.googleMapsController.complete(controller);
                    Position position =
                        await homeController.getMyCurrentLocation();
                    homeController.mapStatus.value = Constants.idle;
                    homeController.moveMapCamera(
                      LatLng(position.latitude, position.longitude),
                      zoom: 16,
                    );
                  },
                ),
                Visibility(
                  visible: true,
                  child: Positioned(
                    bottom: homeController.mapStatus.value == Constants.idle
                        ? 5
                        : 65,
                    left: 5,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: () async {
                        Position position =
                            await homeController.getMyCurrentLocation();
                        homeController.moveMapCamera(
                          LatLng(position.latitude, position.longitude),
                          zoom: 16,
                        );
                      },
                      backgroundColor: const Color.fromARGB(255, 34, 33, 33),
                      child: const Icon(
                        Icons.my_location,
                        color: Color.fromARGB(255, 128, 6, 150),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      homeController.mapStatus.value != Constants.onDestination,
                  child: Positioned(
                    top: 5,
                    child: FutureBuilder(
                      future: homeController.getMyCurrentLocation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MySearchBar(
                            location: LatLng(snapshot.data!.latitude,
                                snapshot.data!.longitude),
                          );
                        } else {
                          return const SizedBox(
                            height: 5,
                            width: 5,
                          );
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: homeController.mapStatus.value == Constants.route,
                  child: const Positioned(
                    top: 0,
                    left: 0,
                    child: DestinationBox(),
                  ),
                ),
                Visibility(
                  visible:
                      homeController.mapStatus.value == Constants.onDestination,
                  child: Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        // color: Colors.red,
                        alignment: Alignment.center,
                        width: size.width * 0.85,
                        child: const DirectionsStatusBar()),
                  ),
                ),
                Visibility(
                  visible: homeController.mapStatus.value != Constants.idle,
                  child: const Positioned(
                    bottom: 0,
                    left: 0,
                    child: BottomBar(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
