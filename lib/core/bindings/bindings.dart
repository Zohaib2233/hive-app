import 'package:beekeep/controllers/apiaryController/add_apiary_controller.dart';
import 'package:beekeep/controllers/apiaryController/add_nuc_controller.dart';
import 'package:beekeep/controllers/authController/login_controller.dart';
import 'package:beekeep/controllers/authController/register_controller.dart';
import 'package:beekeep/controllers/chatControllers/search_user_controller.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_development_controller.dart';
import 'package:beekeep/controllers/homeController/home_controller.dart';
import 'package:beekeep/controllers/homeController/notification_view_controller.dart';
import 'package:beekeep/controllers/profileController/edit_profile_controller.dart';
import 'package:get/get.dart';

import '../../controllers/apiaryController/add_hive_controller.dart';
import '../../controllers/todocontroller/todo_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RegisterController());
    Get.put(LoginController());

  }

}

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RegisterController());
    Get.put(LoginController());
  }

}

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TodoController());
    Get.put(HomeController());
  }

}

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(()=>EditProfileController());
  }

}

class AddHiveBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddHiveController());
    // TODO: implement dependencies
  }

}

class HiveDataBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HiveDataController(Get.arguments));
    Get.put(HiveDevelopmentController());
  }
}

class AddApiaryBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AddApiaryController());

  }

}


class AddNucBinding extends Bindings{
  @override
  void dependencies() {

    Get.put(AddNucController(Get.arguments));
    // TODO: implement dependencies
  }

}


class SearchUserChatBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SearchUserController());
  }

}

class ChatRoomBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.put(MessagesController(chatThreadModel))
    // Get.put(ChatRoomController());
  }

}

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationViewController());
  }

}





