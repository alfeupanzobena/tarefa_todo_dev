import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/providers/providers.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';

class StartDateTime extends ConsumerWidget {
  const StartDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);

    return Text(
      Helpers.dateFormatter(date),
      style: const TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}

class FinishDateTime extends ConsumerWidget {
  const FinishDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);

    return Text(
      Helpers.dateFormatter(date),
      style: const TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}
