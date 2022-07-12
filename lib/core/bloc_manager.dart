import 'package:adactive_todo_test/features/todo/presentation/bloc/task/task_bloc.dart';

import 'dependency_manager.dart';
import '../features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocManager extends StatelessWidget {
  final Widget child;
  const BlocManager({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<TaskBloc>(create: (_) => getIt<TaskBloc>()),
      ],
      child: child,
    );
  }
}
