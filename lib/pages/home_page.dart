import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoos/model/todo_model.dart';
import 'package:todoos/pages/login_register_page.dart';
import 'package:todoos/services/database_services.dart';
import 'package:todoos/widgets/completed_widget.dart';
import 'package:todoos/widgets/pending_widget.dart';

class HomePageController extends GetxController {
  var buttonIndex = 0.obs;
  final DatabaseServices databaseService = DatabaseServices();

  void setButtonIndex(int index) {
    buttonIndex.value = index;
  }

  void showTaskDialog(BuildContext context, {Todo? todo}) {
    final TextEditingController titleController = TextEditingController(text: todo?.title);
    final TextEditingController descriptionController = TextEditingController(text: todo?.description);

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          todo == null ? "Add Task" : "Edit Task",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (todo == null) {
                await databaseService.addTodoTask(
                  titleController.text,
                  descriptionController.text,
                );
              } else {
                await databaseService.updateTodo(
                  todo.id,
                  titleController.text,
                  descriptionController.text,
                );
              }
              Get.back();
            },
            child: Text(todo == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  void logout() {
    Get.offAll(() => LoginRegisterPage());
  }
}

class HomePage extends StatelessWidget {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final _widgets = [
      PendingWidget(),
      CompletedWidget(),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF5E0E9),
      appBar: AppBar(
        backgroundColor: Color(0xFF7843E6),
        foregroundColor: Colors.white,
        title: Text("todoos"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    controller.setButtonIndex(0);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: controller.buttonIndex.value == 0 ? Color(0xFF7843E6) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: controller.buttonIndex.value == 0 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: controller.buttonIndex.value == 0 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                )),
                Obx(() => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    controller.setButtonIndex(1);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: controller.buttonIndex.value == 1 ? Color(0xFF7843E6) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: controller.buttonIndex.value == 1 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: controller.buttonIndex.value == 1 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: 30),
            Obx(() => _widgets[controller.buttonIndex.value]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          controller.showTaskDialog(context);
        },
      ),
    );
  }
}
