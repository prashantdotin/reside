import '../models/task.dart';
import '../models/team_member.dart';

class MockData {
  static const members = <TeamMember>[
    TeamMember(
      id: 'akhil',
      name: 'Akhil Bisht',
      initials: 'AB',
      colorValue: 0xFF6F88A8,
      imagePath: 'assets/images/akhil.png',
    ),

    TeamMember(
      id: 'bilal',
      name: 'Bilal Shaikh',
      initials: 'BS',
      colorValue: 0xFF9A6C4A,
      imagePath: 'assets/images/bilal.png',
    ),

    TeamMember(
      id: 'deepak',
      name: 'Deepak Singh',
      initials: 'DS',
      colorValue: 0xFF6D4C6B,
      imagePath: 'assets/images/deepak.png',
    ),

    TeamMember(
      id: 'hemant',
      name: 'Hemant Kumar',
      initials: 'HK',
      colorValue: 0xFF9AA1A7,
      imagePath: 'assets/images/hemant.png',
    ),
  ];

  static final tasks = <Task>[
    Task(id: '1', title: 'Check if the Oberoi Splendors is available this week with the keys.', assigneeId: 'akhil', status: TaskStatus.open, dueDate: DateTime(2026, 9, 21, 16, 30)),
    Task(id: '2', title: 'Create a Facebook ad campaign targeting young professionals in the city.', assigneeId: 'bilal', status: TaskStatus.open, dueDate: DateTime(2026, 9, 21, 16, 30)),
    Task(id: '3', title: 'Check if the apartment is available', assigneeId: 'deepak', status: TaskStatus.open, dueDate: DateTime(2026, 9, 21, 16, 30)),
    Task(id: '4', title: 'Prepare the property onboarding documents', assigneeId: 'hemant', status: TaskStatus.open, dueDate: DateTime(2026, 9, 22, 11, 0)),
    Task(id: '5', title: 'Share the updated listing photographs with the owner', assigneeId: 'akhil', status: TaskStatus.open, dueDate: DateTime(2026, 9, 23, 10, 0)),
    Task(id: '6', title: 'Follow up with the prospective tenant', assigneeId: 'bilal', status: TaskStatus.overdue, dueDate: DateTime(2026, 9, 19, 16, 30)),
    Task(id: '7', title: 'Confirm the move-in date with the tenant', assigneeId: 'deepak', status: TaskStatus.overdue, dueDate: DateTime(2026, 9, 19, 13, 0)),
    Task(id: '8', title: 'Send maintenance estimate for approval', assigneeId: 'hemant', status: TaskStatus.overdue, dueDate: DateTime(2026, 9, 18, 15, 0)),
    Task(id: '9', title: 'Complete the rental agreement review', assigneeId: 'akhil', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 18, 12, 0), closedAt: DateTime(2026, 9, 18, 11, 45)),
    Task(id: '10', title: 'Update availability in the property portal', assigneeId: 'bilal', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 18, 14, 0), closedAt: DateTime(2026, 9, 18, 13, 30)),
    Task(id: '11', title: 'Verify owner KYC documents', assigneeId: 'deepak', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 17, 15, 0), closedAt: DateTime(2026, 9, 17, 14, 15)),
    Task(id: '12', title: 'Schedule property inspection', assigneeId: 'hemant', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 17, 16, 0), closedAt: DateTime(2026, 9, 17, 15, 20)),
    Task(id: '13', title: 'Review lead notes and next steps', assigneeId: 'akhil', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 16, 16, 0), closedAt: DateTime(2026, 9, 16, 15, 20)),
    Task(id: '14', title: 'Call owner for pricing confirmation', assigneeId: 'akhil', status: TaskStatus.overdue, dueDate: DateTime(2026, 9, 20, 10, 0)),
    Task(id: '15', title: 'Coordinate keys handover', assigneeId: 'bilal', status: TaskStatus.open, dueDate: DateTime(2026, 9, 24, 10, 30)),
    Task(id: '16', title: 'Update tenant contact details', assigneeId: 'deepak', status: TaskStatus.open, dueDate: DateTime(2026, 9, 24, 12, 0)),
    Task(id: '17', title: 'Close duplicate listing issue', assigneeId: 'hemant', status: TaskStatus.open, dueDate: DateTime(2026, 9, 25, 12, 0)),
    Task(id: '18', title: 'Prepare weekly team report', assigneeId: 'akhil', status: TaskStatus.closed, dueDate: DateTime(2026, 9, 20, 17, 0), closedAt: DateTime(2026, 9, 20, 16, 30)),
    ...List.generate(23, (index) {
      final member = members[index % members.length];
      return Task(
        id: 'open-${index + 19}',
        title: 'Review open team task ${index + 1}',
        assigneeId: member.id,
        status: TaskStatus.open,
        dueDate: DateTime(2026, 9, 22 + (index % 5), 9 + (index % 7), 0),
      );
    }),
    ...List.generate(6, (index) {
      final member = members[index % members.length];
      return Task(
        id: 'overdue-${index + 19}',
        title: 'Follow up on overdue team task ${index + 1}',
        assigneeId: member.id,
        status: TaskStatus.overdue,
        dueDate: DateTime(2026, 9, 17 + (index % 3), 10 + (index % 6), 0),
      );
    }),
  ];
}
