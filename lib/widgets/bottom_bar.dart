import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_light_map_for_cars/controllers/home_controller.dart';
import 'package:my_light_map_for_cars/controllers/navigation_controller.dart';
import 'package:my_light_map_for_cars/utils/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    NavigationController navigationController = Get.find();
    return Container(
      color: Color.fromARGB(255, 34, 33, 33),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    homeController.distanceLeft.value,
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(${homeController.timeLeft.value})",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (homeController.mapStatus.value == Constants.route) {
                    navigationController.navigateToDestination();
                  } else {
                    navigationController.stopNavigation();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: homeController.mapStatus.value == Constants.route
                          ? Color.fromARGB(255, 128, 6, 150)
                          : Color.fromARGB(255, 201, 40, 40),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    homeController.mapStatus.value == Constants.route
                        ? "Start"
                        : "Exit",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
