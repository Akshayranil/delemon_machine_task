import 'package:delemon_machine_task/features/screen_project/presentation/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/user/current_user.dart';
import '../../../../core/enums/enums.dart';
import '../projectbloc/project_bloc.dart';
import '../projectbloc/project_event.dart';
import '../projectbloc/project_state.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // Theme state
  bool isDarkMode = true; // default dark mode

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(context.read())..add(LoadProjects()),
      child: Builder(
        builder: (blocContext) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Projects'),
              actions: [
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                  ),
                  onPressed: () {
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  },
                ),
              ],
            ),
            body: BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProjectError) {
                  return Center(child: Text(state.message));
                }

                if (state is ProjectLoaded) {
                  if (state.projects.isEmpty) {
                    return const Center(child: Text('No projects found'));
                  }

                  return ListView.builder(
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];

                      return Card(
                        child: ListTile(
                          title: Text(project.name),
                          subtitle: Text(project.description),
                          onTap: () {
                            context.push('/projects/${project.id}/tasks');
                          },
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'archive') {
                                context
                                    .read<ProjectBloc>()
                                    .add(ArchiveProject(project.id));
                              }
                              if (value == 'report') {
                                context
                                    .push('/projects/${project.id}/report');
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                value: 'report',
                                child: Text('View Report'),
                              ),
                              PopupMenuItem(
                                value: 'archive',
                                child: Text('Archive'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: currentUser.role == UserRole.admin
                  ? () => showAddDialog(blocContext)
                  : null, // disabled for staff
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  
}
