import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp/models/todolist_models.dart';

showTodoBottomSheet(BuildContext context, {Task? task}) {
  TextEditingController titleController =
      TextEditingController(text: task?.taskName ?? "");
  var listModel = Provider.of<TodoListModel>(context, listen: false);
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(top: 8),
        margin: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.3,
        child: SingleChildScrollView(
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
            ],
          ),
        ),
      );
    },
  );
}
