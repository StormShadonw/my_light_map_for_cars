import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter_3/google_places_for_flutter_3.dart';
import 'package:my_light_map_for_cars/controllers/home_controller.dart';

class MySearchBar extends StatelessWidget {
  MySearchBar({super.key, required this.location});
  LatLng location;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    HomeController homeController = Get.find();

    return Center(
      child: SearchGooglePlacesWidget(
        initialContainerHeight: size.height * 0.15,
        icon: Icons.search,
        iconColor: Colors.white,
        strictBounds: true,
        language: "es",
        darkMode: true,
        placeType: PlaceType.establishment,
        placeholder: 'Enter the address',
        location: location,
        radius: 300000,
        apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!,
        onSearch: (Place place) {},
        onSelected: (Place place) async {
          homeController.setDestination(place);
        },
      ),
    );
  }
}
