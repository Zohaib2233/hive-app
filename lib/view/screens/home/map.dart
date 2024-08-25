// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/services/googleMap/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_search_bar_widget.dart';
import 'Custom_Apiary_Information_widget.dart';

class Maplocation extends StatelessWidget {
  const Maplocation({super.key});

  @override
  Widget build(BuildContext context) {
    final PopupController _popupLayerController = PopupController();
    void _showApiariesBottomSheet() {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(h(context, 30)),
            topRight: Radius.circular(h(context, 30)),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: symmetric(
              context,
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonImageView(
                  imagePath: Assets.imagesBottomsheetline,
                  width: 50,
                  height: 5,
                ),
                SizedBox(
                  height: h(context, 10),
                ),
                ApiaryInformationWidget(),
                SizedBox(
                  height: h(context, 10),
                ),
                ApiaryInformationWidget(),
                SizedBox(
                  height: h(context, 10),
                ),
                ApiaryInformationWidget(),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(Assets.imagesFullmap), fit: BoxFit.cover),
        // ),
        child: SafeArea(
          child: Stack(

            children: [
              Obx(()=>FlutterMap(
                    options: MapOptions(
                      onTap: (position,latlng){

                        print("Position = $position lat= $latlng");
                        print(GoogleMapsService.instance.getAddressThroughLatLong(lat: latlng.latitude, long: latlng.longitude));

                      },
                      initialCenter: LatLng(currentLat.value, currentLng.value)
                    ),
                    children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                      CurrentLocationLayer(
                        // followOnLocationUpdate: FollowOnLocationUpdate.always,
                        // turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                        // style: LocationMarkerStyle(
                        //   marker: const DefaultLocationMarker(
                        //     child: Icon(
                        //       Icons.navigation,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        //   markerSize: const Size(20, 20),
                        //   markerDirection: MarkerDirection.heading,
                        // ),
                      ),
                      PopupMarkerLayer(
                          options: PopupMarkerLayerOptions(
                              popupController: _popupLayerController,
                              popupDisplayOptions: PopupDisplayOptions(
                                  builder: (BuildContext context, Marker marker){
                                    final apiary = apiariesGlobal.firstWhere((apiary) =>
                                    apiary.geo.geopoint.latitude == marker.point.latitude &&
                                        apiary.geo.geopoint.longitude == marker.point.longitude);
                                    return Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(apiary.apiaryName),
                                      ),
                                    );
                                  }
                              ),
                              markers: List
                                  .generate(
                                apiariesGlobal.length,
                                    (index) =>
                                    Marker(
                                        point: LatLng(
                                            apiariesGlobal[index].geo.geopoint
                                                .latitude,
                                            apiariesGlobal[index].geo.geopoint
                                                .longitude),
                                        child: CommonImageView(
                                          imagePath: 'assets/images/bee.png',
                                          height: 25,
                                          width: 25,
                                        )),
                              )

                          )),
                      // MarkerLayer(
                      //   markers: List.generate(apiariesGlobalGeos.length, (index) => Marker(point: LatLng(
                      //       apiariesGlobalGeos[index].geopoint.latitude,apiariesGlobalGeos[index].geopoint.longitude
                      //   ), child: CommonImageView(
                      //     imagePath: 'assets/images/bee.png',
                      //     height: 25,
                      //     width: 25,
                      //   )),),
                      // )
                ]),
              ),
              GestureDetector(
                onTap: _showApiariesBottomSheet,
                child: AbsorbPointer(
                  child: Container(
                    padding: all(context, 20),
                      height: 80,
                      child: CustomSearchBar()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
