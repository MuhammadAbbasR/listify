import 'package:flutter/material.dart';

import '../models/Task_Model.dart';


class TaskViewModel extends ChangeNotifier {
  List<Taskmodel> _tasklist = [];
  List<Taskmodel> get tasklist => _tasklist;

  String _filter = "All";

  String get currentfilter => _filter;

  void addTask(Taskmodel task) {
    _tasklist.add(task);
    notifyListeners();
  }

  void removeTask(Taskmodel task) {
    if (_tasklist.contains(task)) {
      _tasklist.remove(task);
      notifyListeners();
    }
  }

  void setcompleted(Taskmodel task) {
    if (task.iscompleted) {
      task.iscompleted = false;
      notifyListeners();
    } else {
      task.iscompleted = true;
      notifyListeners();
    }
  }

  void changefilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Taskmodel> get filtertask {
    if (_filter == 'Completed') {
      return _tasklist.where((task) => task.iscompleted == true).toList();
    } else if (_filter == 'Incomplete') {
      return _tasklist.where((task) => task.iscompleted == false).toList();
    } else {
      return _tasklist.toList();
    }
  }

  List<Taskmodel> get duetask {
    return _tasklist.where((task) => task.iscompleted == false).toList();
  }
}
