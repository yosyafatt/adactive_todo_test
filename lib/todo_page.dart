import 'dart:developer';

import 'features/todo/presentation/bloc/task/task_bloc.dart';

import 'core/dependency_manager.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/todo/domain/entities/task.dart';

class TodoPage extends HookWidget {
  TodoPage({Key? key}) : super(key: key);

  final _bloc = getIt<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    _onNewTaskButtonPressed() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return NewTaskBottomSheet();
          });
    }

    useEffect(() {
      _bloc.add(TaskRetrieved());
      return;
    });

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              getIt<AuthBloc>().add(AuthLogout());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoginSuccess) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
                    child: Text(
                      'Hi, ${state.user.name}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ).copyWith(bottom: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'To do',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskOperationSuccess) {
                  final tasks = state.tasks;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Dismissible(
                        key: ObjectKey('data$index'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.only(right: 16),
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (_) {
                          _bloc.add(TaskRemoved(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${task.description} removed",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                        child: CheckboxListTile(
                          onChanged: (_) {},
                          value: task.isDone,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(task.description),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onNewTaskButtonPressed,
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class NewTaskBottomSheet extends HookWidget {
  NewTaskBottomSheet({
    Key? key,
  }) : super(key: key);

  final _bloc = getIt<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return Container(
      height: 280,
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.grey.shade200,
      // height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Task'),
          TextField(controller: textEditingController),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('12 Mar 2022, 12:00'),
              Switch(value: true, onChanged: (_) {}),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              debugPrint(textEditingController.text);
              _bloc.add(TaskAdded(Task(
                description: textEditingController.text,
                isDone: false,
              )));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48.0),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
