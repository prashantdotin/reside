import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/formatters.dart';
import '../data/mock_data.dart';
import '../models/task.dart';
import 'avatar.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final member = MockData.members.firstWhere(
      (m) => m.id == task.assigneeId,
    );

    final bool overdue = task.status == TaskStatus.overdue;
    final bool closed = task.status == TaskStatus.closed;

    final String statusText;
    final Color statusColor;

    if (overdue) {
      statusText = 'Overdue ${task.overdueDays} day${task.overdueDays == 1 ? '' : 's'}';
      statusColor = const Color(0xFFEC2549);
    } else if (closed) {
      statusText =
          // 'Closed ${formatDateOnly(task.closedAt ?? task.dueDate)}';
          'Closed';
      statusColor = const Color(0xFF477E2D);
    } else {
      statusText = 'Today ${formatDueTime(task.dueDate)}';
      statusColor = const Color(0xFF0803FF);
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(
        12,
        12,
        12,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.flag,
                  color: Color(0xFFECCC25),
                  size: 15,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  task.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF242424),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Assignee
          Row(
            children: [
              Avatar(
                member: member,
                size: 24,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Mr. ${member.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF242424),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Task status
          Row(
            children: [
              Text(
                'To do',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF888888),
                ),
              ),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                ),
              ),
              Flexible(
                child: Text(
                  statusText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}