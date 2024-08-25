import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/firebase_constants.dart';
import '../../core/global/instance_variables.dart';
import '../../core/utils/app_strings.dart';
import '../../models/chat_models/chat_thread_model.dart';
import '../../models/chat_models/message_model.dart';
import '../../models/user_model.dart';
import '../../view/screens/chat/message.dart';
import '../notificationService/local_notification_service.dart';


class ChattingService {
  ChattingService._privateConstructor();

  static ChattingService? _instance;

  static ChattingService get instance {
    _instance ??= ChattingService._privateConstructor();
    return _instance!;
  }

  Future<bool> createGroupChatThread(
      {required String groupName, required List<String> participants}) async {
    try {
      DocumentReference reference = FirebaseConstants.fireStore
          .collection(FirebaseConstants.chatRoomsCollection)
          .doc();

      print("******* Chat Thread Created ******** ${reference.id}");

      ChatThreadModel chatThreadModel = ChatThreadModel(
        isGroupChat: true,
        chatImage: dummyProfile,
        chatTitle: groupName,
        chatHeadId: reference.id,
        // senderName: groupName,
        // receiverName: groupName,
        receiverProfileImage: dummyProfile,
        senderProfileImage: dummyProfile,
        lastMessageTime: DateTime.now(),
        participants: participants,
        // receiverId: userModelGlobal.value.uid,
        // senderID: userModelGlobal.value.uid,
        receiverUnreadCount: 0,
        senderUnreadCount: 0,
      );
      await reference.set(chatThreadModel.toMap());
      return true;
      ///

    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(title: "Failed", message: "ChatRoom Not Created");
      print("Error = $e");
      return false;

    }
  }

  createChatThread({required UserModel userModel,
    required BuildContext context
      }) async {
    try {
      Utils.showProgressDialog(context: context);

      print("participants = ${userModelGlobal.value.uid} , ${userModel.uid}");
      // Query for existing chat thread
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FirebaseConstants.chatRoomsCollection)
          .where(Filter.or(
              Filter('participants',
                  isEqualTo: [userModel.uid,userModelGlobal.value.uid]),
              Filter('participants',isEqualTo:  [userModelGlobal.value.uid, userModel.uid])))

          .get();

      // If chat thread exists, navigate to chat screen
      if (snapshot.docs.isNotEmpty) {
        print("Chatroom already Exists");
        ChatThreadModel chatThreadModel =
            ChatThreadModel.fromMap(snapshot.docs.first);
        Utils.hideProgressDialog(context: context);
        Get.off(()=>ChatRoom(receiverModel: userModel, chatThreadModel: chatThreadModel,));
        ///

      }
      // If chat thread doesn't exist, create a new one
      else {
        DocumentReference reference = FirebaseConstants.fireStore
            .collection(FirebaseConstants.chatRoomsCollection)
            .doc();

        print("******* Chat Thread Created ******** ${reference.id}");

        ChatThreadModel chatThreadModel = ChatThreadModel(
          chatHeadId: reference.id,
          senderName: userModelGlobal.value.name,
          receiverName: userModel.name,
          receiverProfileImage: userModel.profilePicture,
          senderProfileImage: userModelGlobal.value.profilePicture,
          lastMessageTime: DateTime.now(),
          participants: [userModelGlobal.value.uid, userModel.uid],
          receiverId: userModel.uid,
          senderID: userModelGlobal.value.uid,
          receiverUnreadCount: 0,
          senderUnreadCount: 0,
        );
        await reference.set(chatThreadModel.toMap());
        ///
        Utils.hideProgressDialog(context: context);
        Get.off(()=>ChatRoom(receiverModel: userModel, chatThreadModel: chatThreadModel,));

      }
    } catch (e) {
      print('Error creating or accessing chat thread: $e');
      throw Exception(e);
      // Handle the error as needed
    }
  }

  Future sendMessage(
      {required ChatThreadModel chatThreadModel,
      String? message,
        UserModel? receiverUserModel,
      String? lastMessage,fileName,
      required String messageType}) async {
    try {
      DocumentReference reference = FirebaseConstants.fireStore
          .collection(FirebaseConstants.chatRoomsCollection)
          .doc(chatThreadModel.chatHeadId)
          .collection(FirebaseConstants.messagesCollection)
          .doc();



      MessageModel messageModel = MessageModel(
        fileName: fileName??'',
          messageType: messageType,
          message: message ?? '',
          messageId: reference.id,
          sentAt: DateTime.now(),
          sentBy: userModelGlobal.value.uid);

      await reference.set(messageModel.toMap());
      print(
          "Message Send = ${chatThreadModel.senderID} ------------ ${userModelGlobal.value.uid}");
      if (chatThreadModel.senderID == userModelGlobal.value.uid) {
        DocumentReference reference = await FirebaseConstants.fireStore
            .collection(FirebaseConstants.chatRoomsCollection)
            .doc(chatThreadModel.chatHeadId);
        if (lastMessage != null) {
          reference.update({
            'lastMessage': lastMessage,
            'lastMessageTime': DateTime.now(),
            'receiverUnreadCount': FieldValue.increment(1)
          });
        } else {
          reference.update({
            'lastMessage': message,
            'lastMessageTime': DateTime.now(),
            'receiverUnreadCount': FieldValue.increment(1)
          });
        }
      } else {
        await FirebaseConstants.fireStore
            .collection(FirebaseConstants.chatRoomsCollection)
            .doc(chatThreadModel.chatHeadId)
            .update({
          'lastMessage': message,
          'lastMessageTime': DateTime.now(),
          'senderUnreadCount': FieldValue.increment(1)
        });
      }



      LocalNotificationService.instance.sendFCMNotification(
          deviceToken: receiverUserModel?.deviceTokenID??'',
          title: "Hive",
          body: message??'',
          type: "message",
          sentBy: userModelGlobal.value.uid,
          sentTo: receiverUserModel?.uid??'',
          savedToFirestore: false);
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<ChatThreadModel>> streamChatHeads() {
    print("--------------------Stream Chat Heads Call-----------------------");

    try {
      return FirebaseConstants.fireStore
          .collection(FirebaseConstants.chatRoomsCollection)
          .where('participants', arrayContains: userModelGlobal.value.uid)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .map((documents) {

        return documents.docs
            .map((doc) => ChatThreadModel.fromMap(doc))
            .toList();
      });
    } catch (e) {
      print(e);
      print("Catch e Called");

      // return <ChatThreadModel>[];
      throw Exception(e);
    }
  }

  Stream<(List<MessageModel>, DocumentSnapshot?)> fetchMessages(
      {required ChatThreadModel chatThreadModel,DocumentSnapshot? startAfter}) {
    try {
      print("Called fetchMessages");
      Query query = FirebaseConstants.fireStore
          .collection(FirebaseConstants.chatRoomsCollection)
          .doc(chatThreadModel.chatHeadId)
          .collection('messages')
          .orderBy('sentAt', descending: true).limit(10);

      if(startAfter!=null){
        query = query.startAfterDocument(startAfter);
      }


      return query
          .snapshots()
          .map((event) {

            print("Eventsss = ${event.docs.length}");
            // event.docs.last;
        DocumentSnapshot? lastDoc = event.docs.isNotEmpty?event.docs.last:null;
        List<MessageModel> allMessages = event.docs.map((e) => MessageModel.fromJson1(e.data() as Map<String, dynamic>)).toList();
        return (allMessages, lastDoc);

            // return event.docs.map((e) => MessageModel.fromJson1(e.data() as Map<String, dynamic>)).toList();
      });

    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<MessageModel>> fetchGroupMessages(
      {required ChatThreadModel chatThreadModel}) {
    try {
      print("Called fetchMessages");
      return FirebaseConstants.fireStore
          .collection(FirebaseConstants.chatRoomsCollection)
          .doc(chatThreadModel.chatHeadId)
          .collection('messages').where('isGroupChat',isEqualTo: true)
          .orderBy('sentAt', descending: false)
          .snapshots()
          .map((event) =>
          event.docs.map((e) => MessageModel.fromJson1(e.data())).toList());
    } catch (e) {
      throw Exception(e);
    }
  }
}
