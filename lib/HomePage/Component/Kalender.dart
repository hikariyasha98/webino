import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../my_flutter_app_icons.dart';

class WebinoCalender extends StatefulWidget {
  const WebinoCalender({Key? key}) : super(key: key);

  @override
  _WebinoCalenderState createState() => _WebinoCalenderState();
}

class _WebinoCalenderState extends State<WebinoCalender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(105, 191, 233, 1),
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            MyFlutterApp.back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text("Kalender"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 13),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                color: Colors.white,
                //  borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1.0),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TableCalendar(
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      titleCentered: true,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(105, 191, 233, 1),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            25,
                          ),
                          topRight: Radius.circular(
                            25,
                          ),
                        ),
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(236, 236, 236, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                    daysOfWeekHeight: 40,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color.fromRGBO(105, 191, 233, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            13,
                          ),
                        ),
                      ),
                      markerDecoration: BoxDecoration(
                        color: Color.fromRGBO(105, 191, 233, 1),
                      ),
                      //rangeHighlightScale: 10,
                      weekendDecoration: BoxDecoration(),

                      // cellPadding: EdgeInsets.only(top: 10),
                      //   cellMargin: EdgeInsets.all(12),
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                  ),
                  Container(
                    height: 46,
                  )
                ],
              ),
            ),
          ],
        ),
        //   child: CalendarDatePicker(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged),
      ),
    );
  }
}
