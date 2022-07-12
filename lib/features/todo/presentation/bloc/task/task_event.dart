part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskAdded extends TaskEvent {
  final Task task;

  const TaskAdded(this.task);
}

class TaskRemoved extends TaskEvent {
  final num index;

  const TaskRemoved(this.index);
}

class TaskRetrieved extends TaskEvent {}
