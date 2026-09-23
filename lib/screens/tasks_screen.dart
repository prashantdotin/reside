import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/team_controller.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filters.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
    required this.controller,
  });

  final TeamController controller;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabs;

  @override
  void initState() {
    super.initState();

    tabs = TabController(
      length: 3,
      vsync: this,
    );

    tabs.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    tabs.dispose();
    super.dispose();
  }

  TaskStatus get currentStatus {
    return TaskStatus.values[tabs.index];
  }

  @override
  Widget build(BuildContext context) {
    final filters = TaskFilters(
      controller: widget.controller,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _tabs(),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  final tasks =
                      widget.controller.tasksForStatus(currentStatus);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          12,
                          16,
                          12,
                        ),
                        child: filters.buildBar(context),
                      ),

                      Expanded(
                        child: tasks.isEmpty
                            ? const _EmptyState()
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  24,
                                ),
                                itemCount: tasks.length,
                                itemBuilder: (_, index) {
                                  return TaskCard(
                                    task: tasks[index],
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 56,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.chevron_left,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),

          Text(
            "Team's Task",
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF242424),
              height: 1,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabs,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.black,
        indicatorWeight: 2,
        labelColor: const Color(0xFF000000),
        unselectedLabelColor: const Color(0xFF545454),
        labelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'OPEN'),
          Tab(text: 'OVERDUE'),
          Tab(text: 'CLOSED'),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 44,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          Text(
            'No tasks found',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}