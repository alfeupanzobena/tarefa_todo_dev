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
    final selectedCategory = ref.watch(categoryProvider);
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
              itemCount: selectedCategory.categoria.data!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final category = selectedCategory.categoria.data![index];
                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category as TaskCategory;
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
