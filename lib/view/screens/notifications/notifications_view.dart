import 'package:beekeep/controllers/homeController/notification_view_controller.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});




  @override
  Widget build(BuildContext context) {
    NotificationViewController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
        child: Obx(()=>ListView.builder(
          controller: controller.scrollController,
            itemCount: controller.notificationModels.length,
            itemBuilder: (context, index){

            // var now = DateTime.now();
            //
            // now.difference(controller.notificationModels[index].date!);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(

                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: controller.notificationModels[index].title,weight: FontWeight.w700,size: 12,),
                    Text(controller.notificationModels[index].body)
                  ],
                ),
                trailing: Text(timeago.format(controller.notificationModels[index].date!, locale: 'en_short')),

              ),
            );
            },),
        ),
      ),
    );



  }
}
