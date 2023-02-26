import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp/models/todolist_models.dart';

showTodoBottomSheet(BuildContext context, {Task? task}) {
  TextEditingController titleController = TextEditingController(
    text: task?.taskName ?? "",
  );
  var listModel = Provider.of<TodoListModel>(context, listen: false);
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          margin: const EdgeInsets.all(8),
          // height: MediaQuery.of(context).size.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.01,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 64,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      hintText: "Enter Task Name",
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                if (task == null)
                  buildButton("Create", () {
                    listModel.addTask(titleController.text);
                    Navigator.pop(context);
                  }),
                if (task != null)
                  buildButton("Update", () {
                    listModel.updateTask(task.id, titleController.text);
                    Navigator.pop(context);
                  }),
                if (task != null)
                  buildButton("Delete", () {
                    listModel.deleteTask(task.id);
                    Navigator.pop(context);
                  }),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ElevatedButton buildButton(String text, Function onPressed) {
  return ElevatedButton(
    onPressed: onPressed as void Function(),
    child: Container(
      height: 48,
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: text == "Delete" ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
