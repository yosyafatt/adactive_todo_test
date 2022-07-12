import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({required super.description, required super.isDone});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      description: json['description'],
      isDone: json['isDone'] as bool,
    );
  }
}
