import 'package:delemon_machine_task/domain/repository/report_repository.dart';
import 'package:delemon_machine_task/presentation/blocs/reportbloc/report_bloc.dart';
import 'package:delemon_machine_task/presentation/blocs/reportbloc/report_event.dart';
import 'package:delemon_machine_task/presentation/blocs/reportbloc/report_state.dart';
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
                        _tile('Total Tasks', r.total.toString(), Colors.blue),
                        _tile('Done', r.done.toString(), Colors.green),
                        _tile('In Progress', r.inProgress.toString(),
                            Colors.orange),
                        _tile('Blocked', r.blocked.toString(), Colors.red),
                        _tile('Overdue', r.overdue.toString(), Colors.redAccent),
                        _tile('Completion %',
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
                        children: r.openTasksByAssignee.entries.map((e) {
                          return ListTile(
                            title: Text('User: ${e.key}'),
                            trailing: Text('Open Tasks: ${e.value}'),
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

  Widget _tile(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
