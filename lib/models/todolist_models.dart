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
  bool isLoading = false;
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
    List totalTaskList = await _client.call(
      contract: _contract,
      function: _taskCount,
      params: [],
    );
    BigInt totalTask = totalTaskList[0];
    taskCount = totalTask.toInt();
    todos.clear();
    for (var i = 0; i < totalTask.toInt(); i++) {
      var temp = await _client.call(
        contract: _contract,
        function: _todos,
        params: [BigInt.from(i)],
      );
      if (temp[1] != "") {
        todos.add(
          Task(
            id: (temp[0] as BigInt).toInt(),
            taskName: temp[1],
            isCompleted: temp[2],
          ),
        );
      }
    }
    isLoading = false;
    todos = todos.reversed.toList();
    notifyListeners();
  }

  addTask(String taskNameData) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _createTask,
        parameters: [taskNameData],
      ),
    );
    await getTodos();
  }

  updateTask(int id, String taskNameData) async {
    isLoading = true;
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _updateTask,
        parameters: [BigInt.from(id), taskNameData],
      ),
    );
    await getTodos();
  }

  deleteTask(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _deleteTask,
        parameters: [BigInt.from(id)],
      ),
    );
    await getTodos();
  }

  toggleComplete(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _toggleComplete,
        parameters: [BigInt.from(id)],
      ),
    );
    await getTodos();
  }

  Future<void> init() async {
    _client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
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
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(
      jsonAbi["networks"]["5777"]["address"],
    );
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    _ownAddress = _credentials.address;
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
      ContractAbi.fromJson(
        _abiCode,
        "TodoList",
      ),
      _contractAddress,
    );
    _taskCount = _contract.function(
      "taskCount",
    );
    _updateTask = _contract.function(
      "updateTask",
    );
    _createTask = _contract.function(
      "createTask",
    );
    _deleteTask = _contract.function(
      "deleteTask",
    );
    _toggleComplete = _contract.function(
      "toggleComplete",
    );
    _todos = _contract.function(
      "todos",
    );
    await getTodos();
  }
}
