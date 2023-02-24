import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Task {
  final int id;
  final String taskName;
  final bool isCompleted;
  Task({required this.id, required this.taskName, required this.isCompleted});
}

class TodoListModel extends ChangeNotifier {
  TodoListModel() {
    init();
  }

  List<Task> todos = [];
  bool isLoading = true;
  late int taskCount;
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";

  final String _privateKey =
      "0xa94b89a08c74748d1e779ab0abaf597555daedac62dd0a71aa480692c609d791";

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;

  late ContractFunction _taskCount;
  late ContractFunction _todos;
  late ContractFunction _createTask;
  late ContractFunction _updateTask;
  late ContractFunction _deleteTask;
  late ContractFunction _toggleComplete;

  getTodos() async {
    List totalTaskList = await TodoListModel()._client.call(
      contract: TodoListModel()._contract,
      function: TodoListModel()._taskCount,
      params: [],
    );
    BigInt totalTask = totalTaskList[0];
    TodoListModel().taskCount = totalTask.toInt();
    TodoListModel().todos.clear();
    for (var i = 0; i < totalTask.toInt(); i++) {
      var temp = await TodoListModel()._client.call(
        contract: TodoListModel()._contract,
        function: TodoListModel()._todos,
        params: [BigInt.from(i)],
      );
      if (temp[1] != "") {
        TodoListModel().todos.add(
              Task(
                id: (temp[0] as BigInt).toInt(),
                taskName: temp[1],
                isCompleted: temp[2],
              ),
            );
      }
    }
    TodoListModel().isLoading = false;
    TodoListModel().todos = TodoListModel().todos.reversed.toList();
    notifyListeners();
  }

  addTask(String taskNameData) async {
    TodoListModel().isLoading = true;
    notifyListeners();
    await TodoListModel()._client.sendTransaction(
          TodoListModel()._credentials,
          Transaction.callContract(
            contract: TodoListModel()._contract,
            function: TodoListModel()._createTask,
            parameters: [taskNameData],
          ),
        );
    await getTodos();
  }

  updateTask(int id, String taskNameData) async {
    TodoListModel().isLoading = true;
    await TodoListModel()._client.sendTransaction(
          TodoListModel()._credentials,
          Transaction.callContract(
            contract: TodoListModel()._contract,
            function: TodoListModel()._updateTask,
            parameters: [BigInt.from(id), taskNameData],
          ),
        );
    await getTodos();
  }

  deleteTask(int id) async {
    TodoListModel().isLoading = true;
    notifyListeners();
    await TodoListModel()._client.sendTransaction(
          TodoListModel()._credentials,
          Transaction.callContract(
            contract: TodoListModel()._contract,
            function: TodoListModel()._deleteTask,
            parameters: [BigInt.from(id)],
          ),
        );
    await getTodos();
  }

  toggleComplete(int id) async {
    TodoListModel().isLoading = true;
    notifyListeners();
    await TodoListModel()._client.sendTransaction(
          TodoListModel()._credentials,
          Transaction.callContract(
            contract: TodoListModel()._contract,
            function: TodoListModel()._toggleComplete,
            parameters: [BigInt.from(id)],
          ),
        );
    await getTodos();
  }

  Future<void> init() async {
    TodoListModel()._client = Web3Client(
      TodoListModel()._rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(TodoListModel()._wsUrl)
            .cast<String>();
      },
    );

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString(
      "smartcontract/build/contracts/TodoContract.json",
    );
    var jsonAbi = jsonDecode(abiStringFile);
    TodoListModel()._abiCode = jsonEncode(jsonAbi["abi"]);
    TodoListModel()._contractAddress = EthereumAddress.fromHex(
      jsonAbi["networks"]["5777"]["address"],
    );
  }

  Future<void> getCredentials() async {
    TodoListModel()._credentials = await TodoListModel()
        ._client
        .credentialsFromPrivateKey(TodoListModel()._privateKey);
    TodoListModel()._ownAddress = TodoListModel()._credentials.address;
  }

  Future<void> getDeployedContract() async {
    TodoListModel()._contract = DeployedContract(
      ContractAbi.fromJson(
        TodoListModel()._abiCode,
        "TodoList",
      ),
      TodoListModel()._contractAddress,
    );
    TodoListModel()._taskCount = TodoListModel()._contract.function(
          "taskCount",
        );
    TodoListModel()._updateTask = TodoListModel()._contract.function(
          "updateTask",
        );
    TodoListModel()._createTask = TodoListModel()._contract.function(
          "createTask",
        );
    TodoListModel()._deleteTask = TodoListModel()._contract.function(
          "deleteTask",
        );
    TodoListModel()._toggleComplete = TodoListModel()._contract.function(
          "toggleComplete",
        );
    TodoListModel()._todos = TodoListModel()._contract.function(
          "todos",
        );
    await TodoListModel().getTodos();
  }
}
