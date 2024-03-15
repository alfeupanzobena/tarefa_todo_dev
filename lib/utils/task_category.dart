import 'package:flutter/material.dart';

enum TaskCategory {
  education(Text("Educação")),
  health(Text("Saúde")),
  home(Text("Casa")),
  others(Text("Outros")),
  personal(Text("Pessoal")),
  shopping(Text("Compras")),
  social(Text("Social")),
  travel(Text("Viagem")),
  work(Text("Trabalho"));

  static TaskCategory stringToTaskCategory(String name) {
    try {
      return TaskCategory.values.firstWhere(
        (category) => category.name == name,
      );
    } catch (e) {
      return TaskCategory.others;
    }
  }

  final Text categoria;
  const TaskCategory(this.categoria);
}
