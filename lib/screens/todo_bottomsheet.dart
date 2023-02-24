import 'package:flutter/material.dart';
import 'package:todo_dapp/models/todolist_models.dart';

showTodoBottomSheet(BuildContext context, {Task? task}) {
  TextEditingController titleController =
      TextEditingController(text: task?.taskName ?? "");
  TodoListModel listModel = TodoListModel();
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container();
    },
  );
}
