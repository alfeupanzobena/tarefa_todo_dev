import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarefa_todo_dev/config/theme/app_theme.dart';
import 'package:tarefa_todo_dev/providers/category_provider.dart';
import 'package:tarefa_todo_dev/utils/utils.dart';
import 'package:gap/gap.dart';

class CategoriesSelection extends ConsumerWidget {
  const CategoriesSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedCategory = ref.watch(categoryProvider);
    final List<TaskCategory> categories = TaskCategory.values.toList();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Categorias',
            style: TextStyle(color: AppThemeDark.appBarTextColor, fontSize: 22),
          ),
          const Gap(10),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category;
                  },
                  borderRadius: BorderRadius.circular(30),
                );
              },
              separatorBuilder: (context, index) => const Gap(8),
            ),
          ),
        ],
      ),
    );
  }
}
