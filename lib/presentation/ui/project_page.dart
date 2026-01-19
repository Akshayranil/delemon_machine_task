import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/project_entity.dart';
import '../../core/user/current_user.dart';
import '../../domain/entities/enums.dart';
import '../blocs/projectbloc/project_bloc.dart';
import '../blocs/projectbloc/project_event.dart';
import '../blocs/projectbloc/project_state.dart';

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
                  ? () => _showAddDialog(blocContext)
                  : null, // disabled for staff
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext blocContext) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: blocContext,
      builder: (_) {
        return AlertDialog(
          title: const Text('New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(blocContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final project = ProjectEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameCtrl.text,
                  description: descCtrl.text,
                  archived: false,
                );

                blocContext.read<ProjectBloc>().add(AddProject(project));
                Navigator.pop(blocContext);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
