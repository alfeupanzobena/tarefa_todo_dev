import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/providers/providers.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';
import 'common_text_field.dart';

class StartDateTime extends ConsumerWidget {
  const StartDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);

    return CommonTextField(
      hintText: Helpers.dateFormatter(date),
      readOnly: true,
    );
  }
}

class FinishDateTime extends ConsumerWidget {
  const FinishDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);

    return CommonTextField(
      hintText: Helpers.dateFormatter(date),
      readOnly: true,
    );
  }
}
