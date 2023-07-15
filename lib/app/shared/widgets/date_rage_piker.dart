import 'package:flutter/material.dart';
import 'package:wallet_manager/shared/extensions/formate_date.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
  });

  final Function(DateTimeRange) onDateSelected;
  final DateTimeRange initialDate;

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late DateTimeRange selectedDate;

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        start: widget.initialDate.start,
        end: widget.initialDate.end,
      ),
    );

    if (picked != null) {
      setState(() {
        widget.onDateSelected(picked);
        selectedDate = picked;
      });
    }
  }

  String getNameDateByDateRange(DateTimeRange dateRange) {
    return '${selectedDate.start.formatDate(onlyDate: true)} - ${selectedDate.end.formatDate(onlyDate: true)}';
  }

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: Color(0xFFF4F5F8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]),
      child: InkWell(
        onTap: _showDateRangePicker,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 40,
                height: 32,
                decoration: ShapeDecoration(
                  color: Color(0xFFE7EDFD),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF0C1425),
                )),
            SizedBox(
              width: 10,
            ),
            Text(
              getNameDateByDateRange(selectedDate),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
