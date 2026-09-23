import 'package:flutter/material.dart';

import '../controllers/team_controller.dart';
import '../data/mock_data.dart';
import 'avatar.dart';

class TeamMemberMenu extends StatelessWidget {
  const TeamMemberMenu({
    super.key,
    required this.controller,
  });

  final TeamController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Material(
          color: Colors.white,
          elevation: 6,
          borderRadius: BorderRadius.circular(4),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFD6DBE3),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...MockData.members.map(
                    (member) => _member(
                      context,
                      member.id,
                      member.name,
                      member: member,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _member(
    BuildContext context,
    String id,
    String label, {
    required dynamic member,
  }) {
    final selected = controller.selectedMemberId == id;

    return InkWell(
      onTap: () {
        controller.selectMember(id);
      },
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Row(
            children: [
              Avatar(
                member: member,
                size: 36,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444444),
                  ),
                ),
              ),

              if (selected)
                const Icon(
                  Icons.check,
                  size: 18,
                  color: Color(0xFF555555),
                ),
            ],
          ),
        ),
      ),
    );
  }
}