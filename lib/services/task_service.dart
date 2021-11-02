
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class TaskService {

  List<Task> parseTaskList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> getTaskList() async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // final response = await http
    //     .get(Uri.parse(url + "api/v1/models/" + modelId + "/tasks"));

    final response = await http
        .get(Uri.parse(url + "api/v1/models/1/tasks"));
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<bool> createFreeTime(Map<String, dynamic> params) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final message = jsonEncode(params);
    final response = await http.post(
        Uri.parse(
            url + 'api/v1/tasks/free-time'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
      // var responseBody = Task.fromJson(jsonDecode(response.body));
      // return responseBody;
      Fluttertoast.showToast(msg: 'Create success');
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Can not create');
      return false;
    }
  }

  Future<List<Task>> getIncomingTaskList(int castingId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response = await http
        .get(Uri.parse(url + "api/v1/tasks/$modelId/$castingId/task"));
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

}

List<Appointment> getAppointment(TaskListViewModel list) {
  List<Appointment> task = <Appointment>[];
  for (int i = 0; i < list.tasks.length; i++) {
    task.add(Appointment(
        startTime: list.tasks[i].startAt,
        endTime: list.tasks[i].endAt,
        color: MaterialColors.mainColor,
        subject: list.tasks[i].castingName == null
            ? 'Free time'
            : list.tasks[i].castingName));
  }
  return task;
}
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}