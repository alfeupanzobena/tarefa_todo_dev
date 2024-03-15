// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/config/theme/app_theme.dart';
import 'package:tarefa_todo_dev/data/data.dart';
import 'package:tarefa_todo_dev/providers/providers.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';
import 'package:tarefa_todo_dev/widgets/widgets.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    this.isCompletedTasks = false,
    required this.tasks,
  });
  final bool isCompletedTasks;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.20 : deviceSize.height * 0.3;
    final emptyTasksAlert = isCompletedTasks ? '' : '';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksAlert,
                style: TextStyle(
                    color: AppThemeDark.appBarTextColor, fontSize: 20),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];

                return InkWell(
                  onTap: () => showPeriodDialog(context, task, ref),
                  child: TaskTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(tasksProvider.notifier)
                          .updateTask(task)
                          .then((value) {
                        AppAlerts.displaySnackbar(
                          context,
                          task.isCompleted ? '' : '',
                        );
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade200),
            ),
    );
  }

  void showPeriodDialog(BuildContext context, task, ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController titleController = TextEditingController();
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Novo Período',
                style: TextStyle(
                  color: AppThemeDark.appBarTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  size: 26,
                  color: AppThemeDark.dividerComent,
                ),
              ),
            ],
          ),
          content: Column(
            children: [
              CommonTextField(
                hintText: task.title,
                controller: titleController,
              ),
              const SizedBox(height: 20),
              Container(
                color: AppThemeDark.dividerComent,
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: AppThemeDark.dividerComent,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(flex: 1, child: Text('Começa')),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => Helpers.selectDate(context, ref),
                                  child: Container(
                                      height: 40,
                                      color: Colors.white,
                                      child: const StartDateTime()),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Divider(
                              color: Colors.grey.shade400,
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(flex: 1, child: Text('Termina')),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => Helpers.selectDate(context, ref),
                                  child: const FinishDateTime(),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Divider(
                              color: Colors.grey.shade400,
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text('Categoria')),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: DropdownButton<String>(
                                  items: [
                                    'Categoria 1',
                                    'Categoria 2',
                                    'Categoria 3'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 90,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await AppAlerts.showAlertDeleteDialog(
                          context: context,
                          ref: ref,
                          task: task,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Excluir',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemeDark.textButton,
                      ),
                      child: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
