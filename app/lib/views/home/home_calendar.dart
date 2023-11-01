import 'package:app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendar extends ConsumerWidget {
  final DateTime selectedDay;
  final Function(DateTime) setSelectedDay;

  const HomeCalendar({
    required this.selectedDay,
    required this.setSelectedDay,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final today = DateTime.now();
    final firstSignIn = ref.read(authControllerProvider).valueOrNull?.firestoreUser.metadata.creationTime;
    const oneYear = Duration(days: 365);
    final firstDay = firstSignIn?.subtract(const Duration(days: 30)) ?? today.subtract(oneYear);
    final lastDay = today.add(oneYear);

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: colorScheme.onPrimary,
    );

    final calendarStyle = _buildCalendarStyle(colorScheme, textStyle);

    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: selectedDay,
      calendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) => setSelectedDay,
      currentDay: today,
      headerStyle: _buildHeaderStyle(colorScheme, textStyle),
      calendarBuilders: _createCalendarBuilders(
        today,
        colorScheme,
        textStyle,
        calendarStyle,
      ),
      calendarStyle: calendarStyle,
    );
  }

  HeaderStyle _buildHeaderStyle(ColorScheme colorScheme, TextStyle textStyle) {
    final titleTextStyle = textStyle.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.bold
    );

    return HeaderStyle(
      formatButtonVisible: false,
      titleTextStyle: titleTextStyle,
      leftChevronIcon: Icon(
        Icons.arrow_back_ios,
        color: colorScheme.onPrimary,
        size: 14
      ),
      rightChevronIcon: Icon(
        Icons.arrow_forward_ios,
        color: colorScheme.onPrimary,
        size: 14
      ),
    );
  }

  CalendarBuilders _createCalendarBuilders(
    DateTime today,
    ColorScheme colorScheme,
    TextStyle textStyle,
    CalendarStyle calendarStyle,
  ) {    
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;


    return CalendarBuilders(
      dowBuilder: (context, day) {
        final text = DateFormat.E().format(day);

        return Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: day.isAfter(today) ? Colors.grey : colorScheme.onPrimary,
            )
          ),
        );
      },
      selectedBuilder: (context, day, focusedDay) {
        final text = '${day.day}';
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: margin,
          padding: padding,
          decoration: const BoxDecoration(
            color: Colors.black45,
            shape: BoxShape.circle,
            backgroundBlendMode: BlendMode.darken,
          ),
          alignment: alignment,
          child: Text(text, style: TextStyle(
            color: day.isAfter(today) ? Colors.grey : colorScheme.onPrimary,
            fontSize: 16.0,
            fontWeight: isSameDay(day, today) ? FontWeight.bold : FontWeight.normal,
          )),
        );
      },
      defaultBuilder: (context, day, focusedDay) {
        final text = '${day.day}';
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: margin,
          padding: padding,
          alignment: alignment,
          child: Text(text, style: day.isAfter(today)
            ? textStyle.copyWith(
              color: Colors.grey
            )
            : textStyle
          ),
        );
      },
      outsideBuilder: (context, day, focusedDay) {
        final text = '${day.day}';
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: margin,
          padding: padding,
          alignment: alignment,
          child: Text(text, style: day.isAfter(today)
            ? textStyle.copyWith(
              color: Colors.grey
            )
            : textStyle
          ),
        );
      },
    );
  }

  CalendarStyle _buildCalendarStyle(ColorScheme colorScheme, TextStyle textStyle) {
    return CalendarStyle(
      todayTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      todayDecoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      selectedTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16.0,
      ),
      selectedDecoration: const BoxDecoration(
        color: Colors.black45,
        shape: BoxShape.circle,
        backgroundBlendMode: BlendMode.darken
      ),
      weekendTextStyle: textStyle,
      defaultTextStyle: textStyle,
      holidayTextStyle: textStyle,
      outsideTextStyle: textStyle,
      weekNumberTextStyle: textStyle,
    );
  }
}