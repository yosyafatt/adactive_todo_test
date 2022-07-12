import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String description;
  final bool isDone;

  const Task({
    required this.description,
    required this.isDone,
  });

  @override
  List<Object?> get props => [description, isDone];
}
