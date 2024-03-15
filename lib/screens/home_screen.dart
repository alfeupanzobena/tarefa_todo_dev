import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tarefa_todo_dev/config/config.dart';
import 'package:tarefa_todo_dev/data/data.dart';
import 'package:tarefa_todo_dev/providers/category_provider.dart';
import 'package:tarefa_todo_dev/providers/providers.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';
import 'package:tarefa_todo_dev/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _metaUmController = TextEditingController();
  final TextEditingController _metaDoisController = TextEditingController();

  String _selectedCategory = 'Trabalho';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final taskState = ref.watch(tasksProvider);
        final completedTasks = _completeTask(taskState.tasks, ref);

        return Scaffold(
          backgroundColor: AppThemeDark.backgroundMensagemColor,
          appBar: AppBar(
            backgroundColor: AppThemeDark.appBarBackgroungColor,
            title: Text(
              'Configurações',
              style: TextStyle(
                  color: AppThemeDark.appBarTextColor,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                const SizedBox(height: 20),
                Divider(
                  color: AppThemeDark.dividerComent,
                  thickness: 3,
                ),
                const SizedBox(height: 20),
                _buildPeriodsSection(completedTasks),
                const SizedBox(height: 40),
                _buildLogoutButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apelido",
                style: TextStyle(
                  color: AppThemeDark.appBarTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 50,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppThemeDark.dividerComent,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppThemeDark.dividerComent,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: AppThemeDark.backgroundMensagemColor,
                  backgroundImage: const AssetImage('assets/plantando.png'),
                ),
              ),
              title: Text(
                "Editar Foto",
                style: TextStyle(
                  color: AppThemeDark.appBarTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodsSection(List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Períodos",
          style: TextStyle(
            color: AppThemeDark.appBarTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              DisplayListOfTasks(
                tasks: tasks,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 150,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeDark.textButton,
              ),
              onPressed: _showCreatePeriodDialog,
              child: Text(
                "Adicionar Período",
                style: TextStyle(
                  color: AppThemeDark.backgroundMensagemColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      alignment: Alignment.center,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppThemeDark.dividerComent,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            maxRadius: 30,
            backgroundColor: AppThemeDark.backgroundMensagemColor,
            backgroundImage: const AssetImage('assets/plantando.png'),
          ),
        ),
        title: Text(
          "João",
          style: TextStyle(
            color: AppThemeDark.textButton,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: GestureDetector(
          onTap: () => SystemNavigator.pop(),
          child: Text(
            "Sair",
            style: TextStyle(
              color: AppThemeDark.textButton,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  List<Task> _completeTask(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> filteredTask = [];

    for (var task in tasks) {
      if (!task.isCompleted && Helpers.isTaskFromSelectedDate(task, date)) {
        filteredTask.add(task);
      }
    }
    return filteredTask;
  }

  void _showCreatePeriodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                hintText: 'Nomeie seu período',
                color: AppThemeDark.dividerComent,
                controller: _titleController,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: AppThemeDark.dividerComent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppThemeDark.dividerComent,
                    width: 0.5,
                  ),
                ),
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
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                    child: const StartDateTime()),
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
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const FinishDateTime()),
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
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      )),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedCategory,
                                    dropdownColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCategory = newValue!;
                                      });
                                    },
                                    items: [
                                      'Saúde',
                                      'Casa',
                                      'Pessoal',
                                      'Viagem',
                                      'Trabalho'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(flex: 3, child: Text('Meta 1')),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: CommonTextField(
                        hintText: 'Um',
                        color: Colors.white,
                        controller: _metaUmController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(flex: 3, child: Text('Meta 2')),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: CommonTextField(
                        hintText: 'Dois',
                        color: Colors.white,
                        controller: _metaDoisController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: 90,
                child: TextButton(
                  onPressed: () {
                    _createTask();
                    Navigator.of(context).pop();
                    _titleController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemeDark.textButton,
                  ),
                  child: const Text(
                    'Concluír',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final start = ref.watch(dateProvider);
    final finish = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        start: DateFormat('dd/MM/yyyy').format(start),
        finish: DateFormat('dd/MM/yyyy').format(finish),
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Período criada com sucesso');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'O título não pode ficar vazio');
    }
  }
}
