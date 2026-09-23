enum TaskStatus { open, overdue, closed }

enum TaskSort { newest, oldest, titleAsc, titleDesc }

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.assigneeId,
    required this.status,
    required this.dueDate,
    this.closedAt,
  });

  final String id;
  final String title;
  final String assigneeId;
  final TaskStatus status;
  final DateTime dueDate;
  final DateTime? closedAt;

  int get overdueDays {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final diff = today.difference(due).inDays;
    return diff > 0 ? diff : 0;
  }
}