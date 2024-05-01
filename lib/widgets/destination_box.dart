import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_light_map_for_cars/controllers/home_controller.dart';

class DestinationBox extends StatelessWidget {
  const DestinationBox({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Container(
      color: const Color.fromARGB(255, 34, 33, 33),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                homeController.clearDestination();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.all(10),
              child: Obx(
                () => Text(
                  homeController.destination.value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
