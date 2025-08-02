import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colours.dart';

Future<DateTime?> showCustomDatePicker(
    BuildContext context, DateTime initialDate, String calenderTitle,
    {DateTime? minimumDate}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DatePickerBottomSheet(
      initialDate: initialDate,
      calenderTitle: calenderTitle,
      minimumDate: minimumDate,
    ),
  );
}

class DatePickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final String calenderTitle;
  final DateTime? minimumDate;

  const DatePickerBottomSheet(
      {super.key,
      required this.initialDate,
      required this.calenderTitle,
      this.minimumDate});
  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  final int totalMonths = (DateTime(3000).year - DateTime.now().year) * 12;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            // Top Bar
            Row(
              children: [
                const Text('Date Picker',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context, selectedDate),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Select ${widget.calenderTitle}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: totalMonths,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DateTime firstDayOfMonth = DateTime(
                      DateTime.now().year, DateTime.now().month + index, 1);
                  DateTime lastDayOfMonth = DateTime(
                      firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(firstDayOfMonth),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      CustomCalendar(
                        month: firstDayOfMonth,
                        selectedDate: selectedDate,
                        minimumDate: widget.minimumDate,
                        onDaySelected: (selected) {
                          setState(() {
                            selectedDate = selected;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Selected date & Return box
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.calenderTitle,
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(DateFormat('dd MMM ’yy').format(selectedDate),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 16),
            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: MyColors.primaryColorOfApp,
                ),
                onPressed: () {
                  Navigator.pop(context, selectedDate);
                },
                child:
                    const Text('Done', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final DateTime month;
  final DateTime? selectedDate;
  final DateTime? minimumDate;
  final ValueChanged<DateTime> onDaySelected;

  const CustomCalendar({
    super.key,
    required this.month,
    this.selectedDate,
    this.minimumDate,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // Make Sunday = 0

    final minDate = minimumDate ?? DateTime.now();
    final justMinDate = DateTime(minDate.year, minDate.month, minDate.day);

    List<Widget> dayWidgets = [];

    // Add weekday headers
    const weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    dayWidgets.addAll(weekdayLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      final isWeekend = index == 5 || index == 6;

      return Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isWeekend ? 14 : 12,
            color: isWeekend ? Colors.red : Colors.black,
          ),
        ),
      );
    }));

    // Add empty cells for padding before first day
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    // Add each day
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      final isDisabled = date.isBefore(justMinDate);
      final isSelected = selectedDate != null &&
          date.year == selectedDate!.year &&
          date.month == selectedDate!.month &&
          date.day == selectedDate!.day;
      // final isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

      dayWidgets.add(
        GestureDetector(
          onTap: isDisabled
              ? null
              : () {
                  onDaySelected(date);
                },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isSelected ? MyColors.primaryColorOfApp : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: TextStyle(
                color: isDisabled
                    ? Colors.grey
                    : isSelected
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: dayWidgets,
      ),
    );
  }
}