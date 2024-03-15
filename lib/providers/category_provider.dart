import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategory>((ref) {
  return TaskCategory.others;
});
