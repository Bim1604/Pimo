class Task {
  final int id;
  final String startAt;
  final String endAt;
  final int castingId;
  final bool status;
  final String castingName;
  final String modelId;

  Task(
      {this.id,
        this.startAt,
        this.endAt,
        this.status,
        this.castingId,
        this.castingName,
        this.modelId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        castingId: json['castingId'],
        castingName: json['castingName'],
        endAt: json['endAt'],
        status: json['status'],
        startAt: json['startAt'],
        modelId: json['modelId']);
  }
}
