

import 'package:pimo/models/task.dart';
import 'package:pimo/utils/common.dart';

class ModelTaskViewModel {
  Task _task;

  ModelTaskViewModel({Task task}) : _task = task;

  int get id {
    return _task.id;
  }

  DateTime get startAt {
    return parseDatetime(_task.startAt);
  }

  bool get status {
    return _task.status;
  }

  DateTime get endAt {
    return parseDatetime(_task.endAt);
  }

  int get castingId {
    return _task.castingId;
  }

  String get castingName {
    return _task.castingName;
  }

  String get modelId {
    return _task.modelId;
  }

  String get startAtDate {
    return _task.startAt != null ? formatDate(_task.startAt) : 'null';
  }

  String get startAtTime {
    return _task.startAt != null ? formatTime(_task.startAt) : 'null';
  }

  String get endAtDate {
    return _task.endAt != null ? formatDate(_task.endAt) : 'null';
  }

  String get endAtTime {
    return _task.endAt != null ? formatTime(_task.endAt) : 'null';
  }
}