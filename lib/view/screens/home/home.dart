// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_collection_literals

import 'package:beekeep/controllers/homeController/home_controller.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/view/screens/apiary/add_apiary_one_view.dart';
import 'package:beekeep/view/screens/apiary/apiary_details.dart';
import 'package:beekeep/view/screens/apiary/search_apiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_styling.dart';
import '../../../models/apiary_model.dart';
import '../../widget/Custom_Appbar_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_search_bar_widget.dart';
import '../drawer/drawer.dart';
import 'Custom_Apiary_Information_widget.dart';
import 'map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.find<HomeController>();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: const Color(0xffF5F5F5),
      appBar: CustomAppBar(name: userModelGlobal),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => const AddApiaryPartOne(), binding: AddApiaryBinding());
        },
        backgroundColor: kTertiaryColor,
        child: const Icon(
          Icons.add,
          color: kPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: all(context, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                readOnly: true,
                onTap: (){
                  Get.to(()=>SearchApiary());
                },
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: "Location",
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 10),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 250,
                width: double.maxFinite,
                child: Obx(
                  () => FlutterMap(
                    options: MapOptions(
                        initialCenter:
                            LatLng(currentLat.value, currentLng.value),
                        onTap: (postion, latlong) {
                          Get.to(() => Maplocation());
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),


                      MarkerLayer(
                        markers: List.generate(
                          apiariesGlobal.length,
                          (index) => Marker(
                              point: LatLng(
                                  apiariesGlobal[index].geo.geopoint.latitude,
                                  apiariesGlobal[index].geo.geopoint.longitude),
                              child: CommonImageView(
                                imagePath: 'assets/images/bee.png',
                                height: 25,
                                width: 25,
                              )),
                        ),
                      ),
                      CurrentLocationLayer(
                        followOnLocationUpdate: FollowOnLocationUpdate.always,
                        turnOnHeadingUpdate: TurnOnHeadingUpdate.never,

                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: "Apiaries",
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 10),
              ),
              Obx(
                () => userModelGlobal.value.uid.isEmpty
                    ? CircularProgressIndicator()
                    : StreamBuilder(
                        stream: controller.apiaryStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ApiaryModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('No apiaries found'));
                          }

                          List<ApiaryModel> apiaries = snapshot.data!;

                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: apiaries.length,
                            itemBuilder: (context, index) {
                              ApiaryModel apiaryModel = apiaries[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ApiaryDetailsView(
                                        apiaryModel: apiaryModel,
                                      ));
                                },
                                child: ApiaryInformationWidget(
                                  apiaryModel: apiaryModel,
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
