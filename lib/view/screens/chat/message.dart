// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:beekeep/controllers/chatControllers/messages_controller.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/models/chat_models/chat_thread_model.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/chattingService/chatting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../core/utils/utils.dart';
import '../../../services/notificationService/local_notification_service.dart';
import '../../widget/Custom_Appbar_widget.dart';
import 'Custom_Chat_Buble_widget.dart';

class ChatRoom extends StatelessWidget {
  final UserModel receiverModel;
  final ChatThreadModel chatThreadModel;

  ChatRoom(
      {super.key, required this.receiverModel, required this.chatThreadModel});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MessagesController(chatThreadModel));
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: CustomChatAppBar(
        backImagePath: Assets.imagesBack,
        name: chatThreadModel.isGroupChat == true
            ? chatThreadModel.chatTitle!
            : receiverModel.name,
        profileImageUrl: chatThreadModel.isGroupChat == true
            ? dummyProfile
            : receiverModel.profilePicture,
        status: 'Online',
      ),
      // bottomNavigationBar: SendField(
      //   onTap: () async {
      //
      //     await ChattingService.instance.sendMessage(
      //         lastMessage: controller.messageController.text,
      //         message: controller.messageController.text,
      //         chatThreadModel: chatThreadModel, messageType: 'text');
      //
      //     controller.messageController.clear();
      //   },
      //   hintText: 'Type your message',
      //   sendFieldController: controller.messageController,
      // ),
      body: Column(
        children: [
          Obx(() => Visibility(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                visible: controller.isLoadingMore.value,
              )),
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.messagesModel.length,
                itemBuilder: (context, index) {


                  return ChatBubble(
                    time: Utils.formatDateWithTime(
                        controller.messagesModel[index].sentAt!),
                    receiverImg: receiverModel.profilePicture,
                    msg: controller.messagesModel[index].message!,
                    isSender: controller.messagesModel[index].sentBy! ==
                        userModelGlobal.value.uid,
                    isTime: true,
                  );
                },
              ),
            ),
          ),
          SendField(
            onTap: () async {

              if (controller.messageController.text.isNotEmpty) {

                String message = controller.messageController.text;
                controller.messageController.clear();

                if(message.isNotEmpty){
                  await ChattingService.instance.sendMessage(
                      receiverUserModel: receiverModel,
                      lastMessage: message,
                      message: message,
                      chatThreadModel: chatThreadModel,
                      messageType: 'text');
                }


              }


            },
            hintText: 'Type your message',
            sendFieldController: controller.messageController,
          ),
        ],
      ),
    );
  }
}

class SendField extends StatelessWidget {
  SendField({
    Key? key,
    this.hintText,
    this.sendFieldController,
    this.onTap,
  }) : super(key: key);

  String? hintText;
  final void Function()? onTap;
  TextEditingController? sendFieldController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
          color: kGreybackgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: TextFormField(
                  // textAlignVertical: TextAlignVertical.center,
                  controller: sendFieldController,
                  cursorColor: kSecondaryColor,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    hintText: hintText,
                    filled: true,
                    // suffixIcon: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(
                    //         right: 10,
                    //       ),
                    //       child: CommonImageView(
                    //         imagePath: Assets.imagesAdd,
                    //         height: 16,
                    //         width: 16,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    fillColor: kSecondaryColor,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xffE0E0E0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: kTertiaryColor),
                child: const Center(
                  child: Icon(
                    Icons.send,
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
