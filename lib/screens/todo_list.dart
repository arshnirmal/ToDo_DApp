import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp/models/todolist_models.dart';

class TodoList extends StatelessWidget {
  const TodoList({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<TodoListModel>(context, listen: true);
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
        onPressed: () {},
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
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
