import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../controllers/team_controller.dart';

class DurationDropdown extends StatelessWidget {
  const DurationDropdown({super.key, required this.controller});
  final TeamController controller;

  Future<void> _pickRange(BuildContext context) async {
    final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDateRange: DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now()));
    if (range != null) controller.selectDateRange(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: controller.selectedDuration,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
      items: DurationOption.all
          .map((option) => DropdownMenuItem(
              value: option,
              child: Text(option, style: const TextStyle(fontSize: 12))))
          .toList(),
      onChanged: (value) {
        if (value == DurationOption.dateRange) {
          _pickRange(context);
        } else if (value != null) {
          controller.selectDuration(value);
        }
      },
    );
  }
}
