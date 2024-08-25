import 'package:beekeep/models/chat_models/chat_thread_model.dart';
import 'package:beekeep/models/chat_models/message_model.dart';
import 'package:beekeep/services/chattingService/chatting_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  final ChatThreadModel chatThreadModel;

  MessagesController(this.chatThreadModel);

  RxList<MessageModel> messagesModel = <MessageModel>[].obs;
  DocumentSnapshot? lastFetchedDoc;

  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    fetchInitialMessages();
    scrollController.addListener(_scrollListener);
  }

  fetchInitialMessages() {
    ChattingService.instance
        .fetchMessages(chatThreadModel: chatThreadModel)
        .listen((messages) {
      messagesModel.assignAll(messages.$1);
      lastFetchedDoc = messages.$2;

      print("Last Document = ${messages.$2}");
      messagesModel.value = messagesModel.reversed.toList();
    });
  }

  fetchMoreMessages() async {
    isLoadingMore(true);
    ChattingService.instance
        .fetchMessages(
            chatThreadModel: chatThreadModel, startAfter: lastFetchedDoc)
        .listen((messages) {
      print("Last Document = ${messages.$2}");

      if(messages.$2!=null){
        messagesModel.addAll(messages.$1);
        lastFetchedDoc = messages.$2;
        messagesModel.value = messagesModel.reversed.toList();
      }

      isLoadingMore(false);
    });

  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Reached the bottom of the list
    } else if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // Reached the top of the list
      fetchMoreMessages();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    messageController.dispose();
  }
}
