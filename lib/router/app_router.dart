import 'package:delemon_machine_task/features/screen_project/presentation/ui/project_page.dart';
import 'package:delemon_machine_task/features/screen_report/presentation/ui/report_page.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/ui/task_page.dart';

import 'package:go_router/go_router.dart';



class AppRouter {
  static final router = GoRouter(
    initialLocation: '/projects',
    routes: [
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsPage(),
      ),
      GoRoute(
        path: '/projects/:id/tasks',
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          return TasksPage(projectId: projectId);
        },
      ),
      GoRoute(
        path: '/projects/:id/report',
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          return ReportPage(projectId: projectId);
        },
      ),
    ],
  );
}
