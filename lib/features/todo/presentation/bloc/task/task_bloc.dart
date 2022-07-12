import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> tasks = [];

  TaskBloc() : super(TaskInitial()) {
    on<TaskAdded>((event, emit) async {
      emit(TaskAddInProgress());

      tasks.add(event.task);
      await Future.delayed(const Duration(seconds: 3));
      emit(TaskOperationSuccess(tasks));
    });
    on<TaskRemoved>((event, emit) async {
      emit(TaskRemoveInProgress());
      tasks.removeAt(event.index.toInt());
      await Future.delayed(const Duration(seconds: 3));
      emit(TaskOperationSuccess(tasks));
    });
    on<TaskRetrieved>((event, emit) async {
      emit(TaskRetrieveInProgress());
      await Future.delayed(const Duration(seconds: 3));
      emit(TaskOperationSuccess(tasks));
    });
  }
}
