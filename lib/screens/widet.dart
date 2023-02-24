// @override
//   Widget build(BuildContext context) {
//     TodoListModel listModel = TodoListModel();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('ToDo DApp'),
//         centerTitle: true,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return Container();
//             },
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
      // body: listModel.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     : Column(
      //         children: [
      //           SizedBox(
      //             height: MediaQuery.sizeOf(context).height * 0.01,
      //           ),
      //           Expanded(
      //             child: ListView.builder(
      //               itemCount: listModel.todos.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: InkWell(
      //                     onTap: () {
      //                       showTodoBottomSheet(
      //                         context,
      //                         task: listModel.todos[index],
      //                       );
      //                     },
      //                     child: Container(
      //                       margin: const EdgeInsets.symmetric(
      //                         vertical: 2,
      //                         horizontal: 8,
      //                       ),
      //                       padding: const EdgeInsets.all(4),
      //                       decoration: BoxDecoration(
      //                         color: Colors.grey,
      //                         borderRadius: BorderRadius.circular(16),
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Checkbox(
      //                             value: listModel.todos[index].isCompleted,
      //                             onChanged: (val) {
      //                               listModel.toggleComplete(
      //                                 listModel.todos[index].id,
      //                               );
      //                             },
      //                           ),
      //                           Text(
      //                             listModel.todos[index].taskName,
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
  //   );
  // }
