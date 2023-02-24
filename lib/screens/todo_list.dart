import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp/models/todolist_models.dart';
import 'package:todo_dapp/screens/todo_bottomsheet.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<TodoListModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTodoBottomSheet(context);
        },
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),
      ),
      body: listModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ) //YaZ15337
          : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listModel.todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: InkWell(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (val) {
                                      listModel.toggleComplete(
                                        listModel.todos[index].id,
                                      );
                                    },
                                  ),
                                  Text(
                                    listModel.todos[index].taskName,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
