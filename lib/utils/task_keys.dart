import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskKeys {
  const TaskKeys._();
  static const String id = 'id';
  static const String title = 'title';
  static const String category = 'category';
  static const String start = 'start';
  static const String finish = 'finish';
  static const String isCompleted = 'isCompleted';
}
