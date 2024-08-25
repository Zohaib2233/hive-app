import 'package:beekeep/controllers/apiaryController/add_apiary_controller.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/services/googleMap/google_map.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/global/instance_variables.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  AddApiaryController controller = Get.find();
  RxList<Marker> markers = <Marker>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pick Location"),
        ),
        body: Container(
          child: FlutterMap(
            options: MapOptions(
                onTap: (position, latlong) async {

                  controller.apiaryLat.value = latlong.latitude;
                  controller.apiaryLong.value = latlong.longitude;
                  List<Placemark> placeMarks = await GoogleMapsService.instance
                      .getAddressThroughLatLong(
                          lat: latlong.latitude, long: latlong.longitude);
                  markers.clear();
                  markers.add(
                      Marker(point: latlong, child: Icon(Icons.location_on)));
                  setState(() {});
                  Get.bottomSheet(Container(
                    height: Get.height / 2,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 70,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        MyText(
                          text: "Select Appropriate Address",
                          weight: FontWeight.w700,
                          size: 18,
                        ),
                        ...List.generate(placeMarks.length, (index) {
                          String address = "${placeMarks[index].street}, ${placeMarks[index].subLocality} , ${placeMarks[index].country}";
                          return ListTile(
                            onTap: (){
                              controller.locationController.text=address;
                              Get.close(2);
                            },
                            title: Text(
                              address
                                ),
                          );
                        })
                      ],
                    ),
                  ));
                },
                initialZoom: 16,
                initialCenter: LatLng(currentLat.value, currentLng.value)),
            children: [
              TileLayer(
                urlTemplate: openStreetMapUrl,
              ),
              CurrentLocationLayer(),
              MarkerLayer(
                markers: markers,
              )
            ],
          ),
        ));
  }
}
