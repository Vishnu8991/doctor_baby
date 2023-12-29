import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class VaccineCalendar extends StatefulWidget {
  @override
  _VaccineCalendarState createState() => _VaccineCalendarState();
}

class _VaccineCalendarState extends State<VaccineCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  List<DateTime> _vaccineDates = [];
  Map<DateTime, Color> _vaccineColors = {};

  @override
  void initState() {
    super.initState();

    DateTime birthDate = DateTime.now();

    for (int i = 0; i < 12; i++) {
      DateTime vaccineDate = birthDate.add(Duration(days: i * 30));
      _vaccineDates.add(vaccineDate);
      _vaccineColors[vaccineDate] = Colors.black;
      _events[vaccineDate] = ['Vaccine'];
    }
  }

  void _scrollToVaccineDate(DateTime vaccineDate) {
    setState(() {
      _selectedDay = vaccineDate;
      _focusedDay = vaccineDate;
    });
  }

  List<String> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  void _showEventDetails(DateTime selectedDay) {
    List<String> events = _events[selectedDay] ?? [];
    if (events.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Events on ${selectedDay.toString().split(' ')[0]}'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: events.map((event) {
                return Text('- $event');
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Doctor baby', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
              formatButtonDecoration: BoxDecoration(color: Colors.grey),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.grey[300]),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.grey[300]),
                titleTextStyle: TextStyle(color: Colors.grey[300]),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.white),
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showEventDetails(selectedDay);
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final markers = <Widget>[];
        
                  if (events.isNotEmpty) {
                    markers.add(
                      Positioned(
                        bottom: 1,
                        child: Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }
        
                  return Row(children: markers);
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Vaccine Dates:',
                style: TextStyle(letterSpacing: 1.2,fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[300]),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView.builder(
                  itemCount: _vaccineDates.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      color: _vaccineColors[_vaccineDates[index]],
                      child: ListTile(
                        title: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${DateFormat('EEE, MMM dd, yyyy').format(_vaccineDates[index])}',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontSize: 17
                              ),
                            ),
                            
                          ],
                        ),
                        onTap: () {
                          _scrollToVaccineDate(_vaccineDates[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}