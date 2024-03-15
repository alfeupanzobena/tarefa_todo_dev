import 'package:equatable/equatable.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final TaskCategory category;
  final String finish;
  final String start;
  final bool isCompleted;
  const Task({
    this.id,
    required this.title,
    required this.category,
    required this.start,
    required this.finish,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.category: category.name,
      TaskKeys.start: start,
      TaskKeys.finish: finish,
      TaskKeys.isCompleted: isCompleted ? 1 : 0,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map[TaskKeys.id],
      title: map[TaskKeys.title],
      category: TaskCategory.stringToTaskCategory(map[TaskKeys.category]),
      start: map[TaskKeys.start],
      finish: map[TaskKeys.finish],
      isCompleted: map[TaskKeys.isCompleted] == 1 ? true : false,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      category,
      start,
      finish,
      isCompleted,
    ];
  }

  Task copyWith({
    int? id,
    String? title,
    TaskCategory? category,
    String? start,
    String? finish,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      start: start ?? this.start,
      finish: finish ?? this.finish,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
