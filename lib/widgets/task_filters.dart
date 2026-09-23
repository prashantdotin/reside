import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/team_controller.dart';
import '../data/mock_data.dart';
import '../models/task.dart';

class TaskFilters {
  const TaskFilters({
    required this.controller,
  });

  final TeamController controller;

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                4,
                20,
                30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter tasks',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF242424),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Team member',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF242424),
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: controller.selectedMemberId ?? '__all__',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9DEE5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9DEE5),
                        ),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: '__all__',
                        child: Text(
                          'All team members',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ...MockData.members.map(
                        (member) {
                          return DropdownMenuItem(
                            value: member.id,
                            child: Text(
                              member.name,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectMember(
                        value == '__all__' ? null : value,
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showSort(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final options = <(TaskSort, String)>[
              (
                TaskSort.newest,
                'Newest due date',
              ),
              (
                TaskSort.oldest,
                'Oldest due date',
              ),
              (
                TaskSort.titleAsc,
                'Title A–Z',
              ),
              (
                TaskSort.titleDesc,
                'Title Z–A',
              ),
            ];

            return Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                4,
                20,
                30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sort tasks',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF242424),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...options.map(
                    (item) {
                      return RadioListTile<TaskSort>(
                        value: item.$1,
                        groupValue: controller.sort,
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectSort(value);
                          }
                        },
                        title: Text(
                          item.$2,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF444444),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ToolbarButton(
            icon: Icons.filter_alt_outlined,
            label: 'Filters',
            onPressed: () {
              show(context);
            },
          ),
        ),

        const SizedBox(width: 24),

        Expanded(
          child: _ToolbarButton(
            icon: Icons.unfold_more,
            label: 'Sort',
            onPressed: () {
              showSort(context);
            },
          ),
        ),
      ],
    );
  }
}
class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFD9DEE5),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF242424),
            ),

            const SizedBox(width: 8),

            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF242424),
              ),
            ),
          ],
        ),
      ),
    );
  }
}