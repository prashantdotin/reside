import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/team_controller.dart';
import '../data/mock_data.dart';
import '../models/task.dart';
import '../widgets/duration_dropdown.dart';
import '../widgets/performance_card.dart';
import 'tasks_screen.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({
    super.key,
    required this.controller,
  });

  final TeamController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),

            Expanded(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      24,
                    ),
                    children: [
                      // Duration
                      SizedBox(
                        width: double.infinity,
                        child: DurationDropdown(
                          controller: controller,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Team member performance cards
                      ...MockData.members.map(
                        (member) {
                          final open = controller.countFor(
                            member.id,
                            TaskStatus.open,
                          );

                          final overdue = controller.countFor(
                            member.id,
                            TaskStatus.overdue,
                          );

                          final closed = controller.countFor(
                            member.id,
                            TaskStatus.closed,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(12),
                                onTap: () {
                                  controller.selectMember(
                                    member.id,
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TasksScreen(
                                        controller: controller,
                                      ),
                                    ),
                                  );
                                },
                                child: PerformanceCard(
                                  member: member,
                                  open: open,
                                  overdue: overdue,
                                  closed: closed,
                                ),
                              ),
                            ),
                          );
                        },
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

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
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
                color: Color(0xFF000000),
              ),
            ),
          ),

          Text(
            'Team Performance',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0XFF242424),
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}