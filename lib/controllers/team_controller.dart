import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../models/task.dart';

class TeamController extends ChangeNotifier {
  String? selectedMemberId;
  String selectedDuration = 'Today';
  DateTimeRangeValue? selectedRange;
  TaskSort sort = TaskSort.newest;

  List<Task> get allTasks => MockData.tasks;

  List<Task> tasksForStatus(TaskStatus status) {
    var result = allTasks.where((task) => task.status == status).toList();
    if (selectedMemberId != null) {
      result = result.where((task) => task.assigneeId == selectedMemberId).toList();
    }
    result = result.where(_matchesDuration).toList();

    switch (sort) {
      case TaskSort.newest:
        result.sort((a, b) => b.dueDate.compareTo(a.dueDate));
      case TaskSort.oldest:
        result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      case TaskSort.titleAsc:
        result.sort((a, b) => a.title.compareTo(b.title));
      case TaskSort.titleDesc:
        result.sort((a, b) => b.title.compareTo(a.title));
    }
    return result;
  }

  int countFor(String memberId, TaskStatus status) => allTasks.where((task) => task.assigneeId == memberId && task.status == status && _matchesDuration(task)).length;

  int countForStatus(TaskStatus status) => allTasks.where((task) => task.status == status && _matchesDuration(task)).length;

  int totalFor(String memberId) => allTasks.where((task) => task.assigneeId == memberId && _matchesDuration(task)).length;
// List<Task> tasksForStatus(TaskStatus status) {
//   var result = allTasks
//       .where((task) => task.status == status)
//       .toList();

//   // Selected team member ke tasks
//   if (selectedMemberId != null) {
//     result = result
//         .where(
//           (task) => task.assigneeId == selectedMemberId,
//         )
//         .toList();
//   }

//   switch (sort) {
//     case TaskSort.newest:
//       result.sort(
//         (a, b) => b.dueDate.compareTo(a.dueDate),
//       );
//       break;

//     case TaskSort.oldest:
//       result.sort(
//         (a, b) => a.dueDate.compareTo(b.dueDate),
//       );
//       break;

//     case TaskSort.titleAsc:
//       result.sort(
//         (a, b) => a.title.compareTo(b.title),
//       );
//       break;

//     case TaskSort.titleDesc:
//       result.sort(
//         (a, b) => b.title.compareTo(a.title),
//       );
//       break;
//   }

//   return result;
// }
//    int countFor(String memberId, TaskStatus status) {
//   return allTasks.where(
//     (task) =>
//         task.assigneeId == memberId &&
//         task.status == status,
//   ).length;
// }

// int countForStatus(TaskStatus status) {
//   return allTasks.where(
//     (task) => task.status == status,
//   ).length;
// }

// int totalFor(String memberId) {
//   return allTasks.where(
//     (task) => task.assigneeId == memberId,
//   ).length;
// }

  void selectMember(String? id) {
    selectedMemberId = id;
    notifyListeners();
  }

  void selectDuration(String value) {
    selectedDuration = value;
    if (value != 'Date Range') selectedRange = null;
    notifyListeners();
  }

  void selectDateRange(DateTime start, DateTime end) {
    selectedDuration = 'Date Range';
    selectedRange = DateTimeRangeValue(start: _dateOnly(start), end: _dateOnly(end, endOfDay: true));
    notifyListeners();
  }

  void selectSort(TaskSort value) {
    sort = value;
    notifyListeners();
  }

  bool _matchesDuration(Task task) {
    final now = DateTime.now();
    final today = _dateOnly(now);
    DateTime start;
    DateTime end = DateTime(today.year, today.month, today.day, 23, 59, 59);

    switch (selectedDuration) {
      case 'Today':
        start = today;
      case 'Week':
        start = today.subtract(Duration(days: today.weekday - 1));
      case 'Month':
        start = DateTime(today.year, today.month);
      case 'Quarter':
        final quarterStartMonth = ((today.month - 1) ~/ 3) * 3 + 1;
        start = DateTime(today.year, quarterStartMonth);
      case 'Annual':
        start = DateTime(today.year);
      case 'Till Date':
        start = DateTime(2020);
      case 'Date Range':
        start = selectedRange?.start ?? DateTime(2020);
        end = selectedRange?.end ?? end;
      default:
        start = today;  
        
    }

    // Overdue work remains visible for the selected period until its due date,
    // which mirrors how a manager normally reviews outstanding work.
    if (task.status == TaskStatus.overdue) {
      return !task.dueDate.isAfter(end);
    }
    return !task.dueDate.isBefore(start) && !task.dueDate.isAfter(end);
  }

  DateTime _dateOnly(DateTime date, {bool endOfDay = false}) => DateTime(date.year, date.month, date.day, endOfDay ? 23 : 0, endOfDay ? 59 : 0, endOfDay ? 59 : 0);
}

class DateTimeRangeValue {
  const DateTimeRangeValue({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
}
