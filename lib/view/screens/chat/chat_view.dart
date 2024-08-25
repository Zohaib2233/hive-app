// ignore_for_file: prefer_const_constructors

import 'package:beekeep/controllers/chatControllers/chat_view_controller.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/chat_models/chat_thread_model.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'Custom_Chat_Tile_widget.dart';
import 'chat.dart';
import 'chatroom_view.dart';
import 'message.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    ChatViewController controller = Get.put(ChatViewController());
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
          text: 'Chats',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: all(context, 20),
        child: Obx(() => ListView.builder(
              itemCount: controller.chatThreadModels.length,
              itemBuilder: (BuildContext context, int index) {
                ChatThreadModel chatThreadModel =
                    controller.chatThreadModels[index];
                bool isMe =
                    userModelGlobal.value.uid == chatThreadModel.senderID!;
                return CustomChatTile(
                    onTap: () async {
                      Utils.showProgressDialog(context: context);
                      String receiverId = chatThreadModel.participants!
                          .where((id) => id != userModelGlobal.value.uid)
                          .first;
                      DocumentSnapshot? snapshot =
                          await FirebaseCRUDServices.instance.readSingleDoc(
                              collectionReference:
                                  FirebaseConstants.userCollectionReference,
                              docId: receiverId);

                      if (snapshot != null) {
                        UserModel receiverModel = UserModel.fromJson(snapshot);
                        Utils.hideProgressDialog(context: context);
                        Get.to(ChatRoom(
                          receiverModel: receiverModel,
                          chatThreadModel: chatThreadModel,
                        ));
                      } else {
                        CustomSnackBars.instance.showFailureSnackbar(
                            title: "Error", message: "you have internet issue");
                      }
                    },
                    name: chatThreadModel.isGroupChat == true
                        ? chatThreadModel.chatTitle!
                        : isMe
                            ? chatThreadModel.receiverName!
                            : chatThreadModel.senderName!,
                    message: chatThreadModel.lastMessage ?? '',
                    imageUrl: isMe
                        ? chatThreadModel.receiverProfileImage!
                        : chatThreadModel.senderProfileImage!,
                    total: 10);
              },
            )),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: const IconThemeData(size: 22.0),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: kTertiaryColor,
        foregroundColor: kPrimaryColor,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: CommonImageView(
              imagePath: Assets.imagesChat,
              height: 25,
              width: 25,
            ),
            backgroundColor: kSecondaryColor,
            label: 'Chat',
            labelStyle: TextStyle(fontSize: f(context, 12)),
            onTap: () {
              Get.to(() => const Chat(), binding: SearchUserChatBinding());
            },
          ),
          SpeedDialChild(
            child: CommonImageView(
              imagePath: Assets.imagesChatroom,
              height: 25,
              width: 25,
            ),
            backgroundColor: kSecondaryColor,
            label: 'Chatroom',
            labelStyle: TextStyle(fontSize: f(context, 12)),
            onTap: () {
              Get.to(() => ChatRoomView());
            },
          ),
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}
