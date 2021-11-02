import 'package:pimo/models/task.dart';
import 'package:pimo/services/task_service.dart';
import 'package:pimo/viewmodels/model_task_view_model.dart';
import 'package:flutter/material.dart';

class TaskListViewModel with ChangeNotifier {
  List<ModelTaskViewModel> tasks = new List<ModelTaskViewModel>();

  Future<TaskListViewModel> getTaskList() async{
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Task> list = await TaskService().getTaskList();
      notifyListeners();
      this.tasks = list.map((tasks) => ModelTaskViewModel(task: tasks)).toList();
    });
  }

  Future<TaskListViewModel> getIncomingTaskList(int castingId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Task> list = await TaskService().getIncomingTaskList(castingId);
      notifyListeners();
      this.tasks = list.map((tasks) => ModelTaskViewModel(task: tasks)).toList();
    });
  }


}