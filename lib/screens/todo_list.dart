import 'package:flutter/material.dart';
import 'package:todo_dapp/models/todolist_models.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    // TodoListModel listModel = TodoListModel();   
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container();
            },
          );
        },
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),
      ),
      // body: ListView.builder(
      //   itemCount: listModel.taskCount,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(listModel.todos[index].taskName),
      //       trailing: Checkbox(
      //         value: listModel.todos[index].isCompleted,
      //         onChanged: (value) {
      //           listModel.toggleComplete(index);
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
