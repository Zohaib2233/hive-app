import 'package:beekeep/services/notificationService/local_notification_service.dart';
import 'package:get/get.dart';

import '../../models/chat_models/chat_thread_model.dart';
import '../../services/chattingService/chatting_service.dart';

class ChatViewController extends GetxController {
  RxList<ChatThreadModel> chatThreadModels = <ChatThreadModel>[].obs;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("--------------- chat Controller Init--------------------");
    ChattingService.instance.streamChatHeads().listen((event) {
      chatThreadModels.value = event;
    });

    String accessToken = await LocalNotificationService.instance
        .getAccessToken();

    print("Access Token - = $accessToken");


  }
}