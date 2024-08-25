import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../widget/Custom_text_widget.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.msg,
    required this.isSender,
    this.time = "11:30 am",
    // this.day = "Tuesday",
    this.isTime = false,
    required this.receiverImg,
    this.senderImg = Assets.imagesProfile,
    this.name = "Lana Steiner",
  }) : super(key: key);

  final String msg, time, name ;
  final String receiverImg, senderImg;
  final bool isSender, isTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTime) _buildTimeAndSenderRow(),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSender) _buildProfileImage(receiverImg),
            _buildMessageBubble(),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(String imageUrl) {
    return Padding(
      padding: EdgeInsets.only(
        right: isSender ? 0 : 12.0,
        left: isSender ? 12 : 0,
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }

  Widget _buildMessageBubble() {
    return Expanded(
      child: Card(
        color: isSender ? kTertiaryColor : const Color(0xffF2F4F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: Radius.circular(isSender ? 0 : 8),
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: CustomText(
            text: msg,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeAndSenderRow() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: 15,
        left: 15,
      ),
      child: Row(
        children: [
          CustomText(
            text: isSender ? 'You' : name,
            size: 10,
            paddingLeft: isSender ? 0 : 50,
            weight: FontWeight.w400,
          ),
          const Spacer(),
          // CustomText(
          //   text: day,
          //   color: kGreyColor,
          //   size: 10,
          //   weight: FontWeight.w400,
          //   paddingRight: 3,
          // ),
          CustomText(
            text: time,
            color: kGreyColor,
            size: 10,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
