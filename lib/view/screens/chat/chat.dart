import 'package:beekeep/controllers/chatControllers/search_user_controller.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/chattingService/chatting_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

SearchUserController controller = Get.find();

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
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
            text: 'Chat',
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
            onTap: () async {
              if (controller.selectedUserIndex.value >= 0) {
                await ChattingService.instance.createChatThread(
                    userModel: controller.selectedUserModel, context: context);
              }
            },
          ),
        ),
        body: Padding(
          padding: symmetric(context, horizontal: 20, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              onChanged: (string) {
                setState(() {print(string);});

                // controller.searchUsers(string);
              },
              hintText: 'Enter email or search contacts',
              controller: controller.searchController,
            ),
            SizedBox(
              height: h(context, 15),
            ),

            ///
            Expanded(
              child: FutureBuilder(
                future: FirebaseConstants.userCollectionReference
                    .where(Filter.or(
                        Filter('phoneNo',
                            isGreaterThanOrEqualTo:
                                controller.searchController.text),
                        Filter('email',
                            isGreaterThanOrEqualTo:
                                controller.searchController.text)))
                    .where('uid', isNotEqualTo: userModelGlobal.value.uid)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData) {
                    return const Text("No result found");
                  } else {
                    QuerySnapshot data = snapshot.data;
                    return ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        UserModel userModel =
                            UserModel.fromJson(data.docs[index]);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => ListTile(
                              onTap: () {
                                controller.selectedUserModel = userModel;
                                controller.selectedUserIndex.value = index;
                              },
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      width: 2,
                                      color:
                                          controller.selectedUserIndex.value ==
                                                  index
                                              ? kBorderColor
                                              : Colors.white)),
                              title: Text("${userModel.name}"),
                              subtitle: Text(
                                  "${userModel.email} | ${userModel.phoneNo}"),
                              leading: CommonImageView(
                                url: userModel.profilePicture,
                                radius: 50,
                                height: 50,
                                width: 55,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
