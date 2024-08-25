import 'package:beekeep/controllers/apiaryController/apiary_detail_controller.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/screens/nuc/add_nuc_basic_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../models/apiary_model.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_hive_widget.dart';
import '../hive/add_hive_basic_details.dart';
import '../hive/check_hive_data_view.dart';
import '../home/Custom_Apiary_Information_widget.dart';

class ApiaryDetailsView extends StatelessWidget {
  final ApiaryModel apiaryModel;

  const ApiaryDetailsView({super.key, required this.apiaryModel});

  // String menuController = 'Hives';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ApiaryDetailController(apiaryModel.apiaryId));
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: h(context, 29),
              height: w(context, 29),
              child: CommonImageView(
                imagePath: Assets.imagesBack,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: apiaryModel.apiaryName,
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.indexValue.value == 0) {
            Get.to(
                () => AddHiveBasicDetailsView(
                      apiaryModel: apiaryModel,
                    ),
                binding: AddHiveBinding());
          } else {
            Get.to(
                () => AddNucBasicDetail(
                      apiaryModel: apiaryModel,
                    ),
                binding: AddNucBinding(),
                arguments: apiaryModel);
          }
        },
        shape: const CircleBorder(),
        backgroundColor: kTertiaryColor,
        child: const Icon(
          Icons.add,
          color: kPrimaryColor,
        ),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              ApiaryInformationWidget(
                isApiaryDetail: true,
                apiaryModel: apiaryModel,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(h(context, 7))),
                height: 60,
                child: Center(
                  child: ListTile(
                    dense: true,
                    title: CustomText(
                      text: '3 Tasks to do',
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    trailing: CommonImageView(
                      imagePath: Assets.imagesTrailingIcon,
                      width: 6,
                      height: 12,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h(context, 15),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(h(context, 7))),
                height: 60,
                child: Center(
                  child: ListTile(
                    dense: true,
                    title: ImageStack(
                      imageList: List.generate(
                        apiaryModel.assignPeople.length,
                        (index) => dummyProfile,
                      ),
                      totalCount: apiaryModel.assignPeople.length,
                      imageRadius: 30,
                      imageCount: 4,
                      imageBorderWidth: 1,
                      imageSource: ImageSource.Network,
                      backgroundColor: kPrimaryColor,
                      extraCountTextStyle: TextStyle(
                          color: kSecondaryColor,
                          fontSize: f(context, 12),
                          fontWeight: FontWeight.w600),
                      extraCountBorderColor: kSecondaryColor,
                    ),
                    trailing: CommonImageView(
                      imagePath: Assets.imagesTrailingIcon,
                      width: 6,
                      height: 12,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h(context, 15),
              ),
              Obx(
                () => Container(
                  height: h(context, 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(h(context, 7)),
                  ),
                  child: Row(
                      children: List.generate(
                    2,
                    (index) => Expanded(
                      child: buildMenu(
                          haveSelected: controller.indexValue.value == index
                              ? true
                              : false,
                          title: index == 0 ? 'Hives' : 'NUCs',
                          // controller: menuController,
                          onTap: (value) {
                            controller.indexValue.value = index;
                          }),
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: h(context, 15),
              ),
              Obx(() => controller.indexValue.value == 0
                  ? ListView.builder(
                shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.hiveModels.length,
                      itemBuilder: (BuildContext context, int index) {
                        HiveModel hiveModel = controller.hiveModels[index];
                        return GestureDetector(
                            onTap: () {
                              Get.to(() {
                                return CheckHiveDataView(
                                  hiveModel: hiveModel,
                                  apiaryModel: apiaryModel,
                                );
                              },
                                  binding: HiveDataBinding(),
                                  arguments: hiveModel);
                            },
                            child: CustomHiveWidget(
                              isContainMenu: true,
                              hiveModel: hiveModel,
                              apiaryModel: apiaryModel,
                            ));
                      },
                    )
                  : FetchAllNucs(apiaryModel: apiaryModel)),
              // ? FutureBuilder(
              //     future:
              //         controller.fetchHives(apiaryId: apiaryModel.apiaryId),
              //     builder: (BuildContext context,
              //         AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              //       if (snapshot.connectionState ==
              //           ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       }
              //
              //       if (snapshot.hasError) {
              //         return Center(
              //             child: Text('Error: ${snapshot.error}'));
              //       }
              //
              //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //         return Center(child: Text('No Hives'));
              //       }
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: snapshot.data!.docs.length,
              //         itemBuilder: (context, index) {
              //           HiveModel hiveModel = HiveModel.fromDocument(
              //               snapshot.data!.docs[index]);
              //           return GestureDetector(
              //               onTap: () {
              //                 Get.to(() {
              //                   return CheckHiveDataView(
              //                     hiveModel: hiveModel,
              //                     apiaryModel: apiaryModel,
              //                   );
              //                 },
              //                     binding: HiveDataBinding(),
              //                     arguments: hiveModel);
              //               },
              //               child: CustomHiveWidget(
              //                 hiveModel: hiveModel,
              //                 apiaryModel: apiaryModel,
              //               ));
              //         },
              //       );
              //     },
              //   )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenu(
      {bool haveSelected = false,
      required String title,

      // String controller,
      required void Function(String value) onTap}) {
    return InkWell(
      onTap: () {
        onTap(title);
      },
      child: Container(
        decoration: BoxDecoration(
            color: haveSelected ? kTertiaryColor : kSecondaryColor,
            borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: CustomText(
            text: title,
            color: haveSelected ? kFullBlackBgColor : kGreyColor,
            size: 14,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FetchAllNucs extends StatelessWidget {
  final ApiaryModel apiaryModel;

  const FetchAllNucs({super.key, required this.apiaryModel});

  @override
  Widget build(BuildContext context) {
    ApiaryDetailController controller = Get.find();

    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.nucModels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: CustomHiveWidget(
                nucModel: controller.nucModels[index],
                apiaryModel: apiaryModel,
              ));
        },
      ),
    );
  }
}
