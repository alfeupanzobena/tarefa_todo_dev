import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/data/datasource/datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});
