import 'package:beekeep/controllers/todocontroller/add_todo_controller.dart';
import 'package:beekeep/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTaskAssignee extends StatelessWidget {
  const SelectTaskAssignee({super.key});

  @override
  Widget build(BuildContext context) {
    AddTodoController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Assignee"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
        child: Obx(()=>
            controller.assignsModel.isEmpty?Center(child: CircularProgressIndicator(),):

            ListView.builder(
            itemCount: controller.assignsModel.length,
            itemBuilder: (context, index) => Material(
              color: Colors.white,
              elevation: 10,
              child: ListTile(
                onTap: (){
                  print("${controller.assignsModel[index].name}");
                  controller.assignController.text = controller.assignsModel[index].name;
                  controller.assigneeId = controller.assignsModel[index].uid;
                  controller.selectedAssign = controller.assignsModel[index];
                  Get.back();
                },
                // tileColor: kBorderColor,
                contentPadding: EdgeInsets.all(10),
                leading: CommonImageView(
                  url: controller.assignsModel[index].profilePicture,
                  radius: 50,
                  height: 55,
                  width: 60,
                ),
                title: Text("${controller.assignsModel[index].name}"),
                subtitle: Text("${controller.assignsModel[index].email} | ${controller.assignsModel[index].phoneNo}"),
              ),
            ),),
        ),
      ),
    );
  }
}
