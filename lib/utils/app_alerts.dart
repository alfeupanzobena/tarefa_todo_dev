import 'package:flutter/material.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/data/data.dart';
import 'package:tarefa_todo_dev/providers/providers.dart';
import 'package:go_router/go_router.dart';

@immutable
class AppAlerts {
  const AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        backgroundColor: context.colorScheme.onSecondary,
      ),
    );
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Task task,
  }) async {
    Widget cancelButton = TextButton(
      child: const Text('NÃO'),
      onPressed: () => context.pop(),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(tasksProvider.notifier).deleteTask(task).then(
          (value) {
            displaySnackbar(
              context,
              'Período excluído com sucesso',
            );
            context.pop();
          },
        );
      },
      child: const Text('SIM'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Tem certeza de que deseja excluir este período'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
