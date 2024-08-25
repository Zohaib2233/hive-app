import 'package:beekeep/controllers/chatControllers/chatroom_view_controller.dart';
import 'package:beekeep/core/utils/validators.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/view/widget/custom_search_bar_widget.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class ChatRoomView extends StatelessWidget {
  ChatRoomView({super.key});

  GlobalKey<FormState> chatRoomNameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ChatroomViewController controller = Get.put(ChatroomViewController());
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
          text: 'Chatroom',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      bottomNavigationBar: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: CustomButton3(
          borderRadius: 8,
          buttonText: "Start Chat",
          onTap: () async{
            if(chatRoomNameKey.currentState!.validate()){
              await controller.createChatRoom(context: context);
            }
          },
        ),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: chatRoomNameKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Name',
                  size: 14,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField2(
                  hintText: 'Enter the name for the chatroom',
                  controller: controller.chatRoomNameController,
                  validator: ValidationService.instance.emptyValidator,
                ),
                SizedBox(
                  height: h(context, 12),
                ),
                Obx(
                  () => CustomText(
                    text: '${controller.selectedUsers.length} Contacts Selected',
                    size: 12,
                    weight: FontWeight.w400,
                    color: kGreyColor,
                  ),
                ),
                SizedBox(
                  height: h(context, 17),
                ),
                Container(
                  height: Get.height * 0.05,
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.selectedUsers.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 48,
                          width: 45,
                          child: Stack(
                            children: [
                              CommonImageView(
                                radius: 50,
                                url: controller
                                    .selectedUsers[index].profilePicture,
                                fit: BoxFit.contain,
                                height: 42,
                                width: 42,
                              ),
                              Positioned(
                                  top: -1,
                                  right: -0,
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Delete called");
                                      controller.selectedUsers.removeAt(index);
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.blueAccent,
                                      size: 18,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h(context, 12),
                ),
                CustomSearchBar(
                  controller: controller.searchUserController,
                  onChanged: (string) {
                    controller.searchUsers(string);
                  },
                  hintText: "Search for contacts",
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Select Contacts',
                  size: 12,
                  weight: FontWeight.w400,
                  color: kGreyColor,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.searchResults.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserModel userModel =
                          UserModel.fromJson(controller.searchResults[index]);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userModel.profilePicture),
                                  ),
                                ),
                                SizedBox(
                                  width: h(context, 9),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: userModel.name,
                                      size: 14,
                                      weight: FontWeight.w400,
                                      color: kFullBlackBgColor,
                                    ),
                                    MyText(
                                        text:
                                            "${userModel.email} | ${userModel.phoneNo}")
                                  ],
                                ),
                                Spacer(),
                                Obx(
                                  () => Checkbox(
                                      value: controller.selectedUsers.any(
                                          (user) =>
                                              user.email == userModel.email),
                                      onChanged: (value) {
                                        // if (controller.selectedUsers
                                        //     .contains(userModel)) {
                                        //   controller.selectedUsers
                                        //       .remove(userModel);
                                        // } else {
                                        //
                                        // }
                                        if (!controller.selectedUsers.any(
                                            (user) =>
                                                user.email == userModel.email ||
                                                user.phoneNo ==
                                                    userModel.phoneNo)) {
                                          controller.selectedUsers.add(userModel);
                                        } else {
                                          controller.selectedUsers
                                              .remove(userModel);
                                        }

                                        print(
                                            "Selected Users = ${controller.selectedUsers}");
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: h(context, 8),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
