import 'package:flutter/material.dart';
import 'package:todo_dapp/models/todolist_models.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    TodoListModel listModel = TodoListModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ToDo DApp'),
        centerTitle: true,
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
        child: const Icon(Icons.add),
      ),
      body: listModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listModel.todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          onTap: () {
                            // showBottomSheet(context: context, builder: builder);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
