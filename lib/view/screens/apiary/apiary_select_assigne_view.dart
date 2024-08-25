import 'package:beekeep/controllers/apiaryController/apiary_assign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class ApiarySelectAssignee extends StatelessWidget {
  const ApiarySelectAssignee({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ApiaryAssignController>();
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
          text: 'Assignee',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'To',
              size: 14,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            CustomTextField2(
                controller: controller.searchEditingController,
                onChanged: (query) {
                  controller.searchUsers(query);
                },
                hintText: 'Enter email or search contacts'),
            SizedBox(
              height: h(context, 15),
            ),
            Obx(
              () => controller.isLoading.value &&
                      controller.searchResults.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isLoading.value &&
                              controller.hasMore.value &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            controller.loadMore();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: controller.searchResults.length + 1,
                          itemBuilder: (context, index) {
                            if (index == controller.searchResults.length) {
                              return controller.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : SizedBox.shrink();
                            }
                            var user = controller.searchResults[index];
                            return GetBuilder<ApiaryAssignController>(builder: (controller) {
                              return ListTile(
                                onTap: (){
                                  controller.selectUser(user);
                                },

                                leading: CommonImageView(
                                  radius: 100,
                                  height: 55,
                                  width: 65,
                                  url: user.profilePicture,
                                ),
                                title: Text(user.email ?? 'No Info'),
                                subtitle: Text(user.phoneNo ?? ''),
                                trailing: controller.selectedUsers.contains(user.uid)
                                    ? const Icon(
                                  Icons.check_box,
                                  size: 15,
                                  color: Colors.blue,
                                )
                                    : SizedBox.shrink(),
                              );
                            },);
                          },
                        ),
                      ),
                    ),
            ),

            CustomButton(
              borderRadius: 8,
              buttonText: "Assign",
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}

