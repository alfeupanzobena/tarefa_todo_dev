import 'package:flutter/material.dart';
import 'package:tarefa_todo_dev/config/theme/app_theme.dart';
import 'package:tarefa_todo_dev/data/data.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    this.onCompleted,
  });

  final Task task;

  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    //final colors = context.colorScheme;

    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
      decoration: BoxDecoration(
        color: AppThemeDark.backgroundMensagemColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            task.title,
            style: style.titleMedium?.copyWith(
                fontWeight: fontWeight,
                fontSize: 16,
                decoration: textDecoration,
                color: AppThemeDark.primaryTextColor),
          ),
          Row(
            children: [
              Text(
                task.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                    color: AppThemeDark.appBarTextColor,
                    fontSize: 13),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                "a",
                style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                    color: AppThemeDark.appBarTextColor,
                    fontSize: 13),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                task.finish,
                style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                    color: AppThemeDark.appBarTextColor,
                    fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
