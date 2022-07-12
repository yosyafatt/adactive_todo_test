part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskAddInProgress extends TaskState {}

class TaskOperationSuccess extends TaskState {
  final List<Task> tasks;

  TaskOperationSuccess(this.tasks);
}

class TaskRemoveInProgress extends TaskState {}

class TaskRetrieveInProgress extends TaskState {}
