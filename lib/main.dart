import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp/models/todolist_models.dart';
import 'package:todo_dapp/screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoList(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
