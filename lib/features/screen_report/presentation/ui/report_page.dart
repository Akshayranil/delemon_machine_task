import 'package:delemon_machine_task/features/screen_report/domain/repository/report_repository.dart';
import 'package:delemon_machine_task/features/screen_report/presentation/reportbloc/report_bloc.dart';
import 'package:delemon_machine_task/features/screen_report/presentation/reportbloc/report_event.dart';
import 'package:delemon_machine_task/features/screen_report/presentation/reportbloc/report_state.dart';
import 'package:delemon_machine_task/features/screen_report/presentation/widget/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReportPage extends StatelessWidget {
  final String projectId;
  const ReportPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportBloc(context.read<ReportRepository>())
        ..add(LoadReport(projectId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Project Report')),
        body: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ReportError) {
              return Center(child: Text(state.message));
            }

            if (state is ReportLoaded) {
              final r = state.report;

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        tile('Total Tasks', r.total.toString(), Colors.blue),
                        tile('Done', r.done.toString(), Colors.green),
                        tile('In Progress', r.inProgress.toString(),
                            Colors.orange),
                        tile('Blocked', r.blocked.toString(), Colors.red),
                        tile('Overdue', r.overdue.toString(), Colors.redAccent),
                        tile('Completion %',
                            '${r.completionPercent.toStringAsFixed(1)}%',
                            Colors.purple),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Open Tasks by Assignee',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: r.openTasksByAssignee.map((e) {
  return ListTile(
    title: Text('User: ${e.username}'),
    trailing: Text('Open Tasks: ${e.openCount}'),
  );
}).toList(),

                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
