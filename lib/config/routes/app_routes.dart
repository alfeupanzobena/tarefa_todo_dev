import 'package:tarefa_todo_dev/config/config.dart';
import 'package:tarefa_todo_dev/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
];
