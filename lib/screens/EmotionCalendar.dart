import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class EmotionCalendar extends StatefulWidget {
  @override
  _EmotionCalendarState createState() => _EmotionCalendarState();
}

class _EmotionCalendarState extends State<EmotionCalendar> with TickerProviderStateMixin{
  Map<DateTime, List<EmotionRecord>> _ventTimes = Map<DateTime, List<EmotionRecord>>();
  List _selectedEvents = [];
  CalendarController _calendarController;
  Set<DateTime> ventDates = Set();
  AnimationController _animationController;
  DateTime currentSelectedDay;
  
  bool isMonthFormat = true;

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      currentSelectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void initState(){
    super.initState();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 500),
    );

    _animationController.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    List<EmotionRecord> emotionRecord = context.watch<List<EmotionRecord>>();

    emotionRecord.forEach((record){
      var year = record.timestamp.year;
      var month = record.timestamp.month;
      var day = record.timestamp.day;
      ventDates.add(DateTime(year, month, day));
    });

    ventDates.forEach((uniqueDate){
      print('${ventDates.toString()}');
      List<EmotionRecord> activities = [];
      emotionRecord.forEach((emotion){
        var year = emotion.timestamp.year;
        var month = emotion.timestamp.month;
        var day = emotion.timestamp.day;
        print("Found emotion at timestamp: ${day}/${month}/${year}");
        var emotionDate = DateTime(year, month, day);
        if (uniqueDate.toString() == emotionDate.toString()){
          activities.add(emotion);
        }
      });
      _ventTimes[uniqueDate] = activities;
    });
    
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Stack(
            children: <Widget>[

              Positioned(
                left: getWidth(context) / 4,
                top: -5,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/fading-dots.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Emotion Calendar',
              style: TextStyle(
                color: Colors.brown[600],
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w800,
                fontSize: ResponsiveFlutter.of(context).scale(20.0),
              ),
            ),
          ),

            ],
          ),

          

          Padding(
            padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(7.0)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.grey[50],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Column(
                  children: [
                    _buildTableCalendar(),
                    GestureDetector(
                      onTap: () {
                        if (isMonthFormat){
                          setState(() {
                            _calendarController.setCalendarFormat(CalendarFormat.week);
                            isMonthFormat = false;
                          });
                        } else {
                          setState(() {
                            _calendarController.setCalendarFormat(CalendarFormat.month);
                            isMonthFormat = true;
                          });
                        }
                        
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: ResponsiveFlutter.of(context).verticalScale(30.0),
                          color: Colors.grey[400],
                          child: Center(
                            child: Text(
                              "Tap to minimize or expand the calendar!",
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),

          (currentSelectedDay != null) ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
            child: Text(
              "Activities done in: " + currentSelectedDay.day.toString() + "/" + currentSelectedDay.month.toString() + "/" + currentSelectedDay.year.toString(), 
              style: TextStyle(
                color: Colors.black, 
                fontSize: ResponsiveFlutter.of(context).scale(15),
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w700,
              )
            ),
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Choose a day inside the calendar!",
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                    fontSize: ResponsiveFlutter.of(context).scale(14.0)
                  ),
                )
              ),
            ],
          ),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar(){
    return TableCalendar(
      calendarController: _calendarController,
      events: _ventTimes,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: ResponsiveFlutter.of(context).scale(14.0),
          color: Colors.red[300],
        ),
        weekdayStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: ResponsiveFlutter.of(context).scale(14.0),
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(top: 7, bottom: 1, left: 5, right: 5),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: ResponsiveFlutter.of(context).scale(12.0),
        ),
        weekendStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: ResponsiveFlutter.of(context).scale(12.0),
        ),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: ResponsiveFlutter.of(context).scale(20.0),
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
          color: Color(0xffffb5b5),
        ),
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(
                "${date.day}",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Proxima Nova',
                  fontSize: ResponsiveFlutter.of(context).scale(14.0)
                ),
              ),
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.deepOrange[300],
              ),
              margin: const EdgeInsets.all(4.0),
              padding: EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontSize: ResponsiveFlutter.of(context).scale(16.0),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.amber[500],
            ),
            margin: const EdgeInsets.all(4.0),
            padding: EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontSize: ResponsiveFlutter.of(context).scale(16.0),
                ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays){
          final children = <Widget>[];

          if (events.isNotEmpty){
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildsEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        }
      ),
      onDaySelected: (date, events, holidays){
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildsEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Color(0xff7ed0b3),
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          "${events.length}",
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {

    //final dateTime = _events.keys.elementAt(_events.length - 2);
    final dateTime = DateTime.now();

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            ElevatedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            ElevatedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList(){
    return ListView(
      children: _selectedEvents
        .map((event) => Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            elevation: 2,
            child: ClipPath(
              child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.green, width: 8))
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.0),
                        isThreeLine: true,
                        tileColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        // leading: CircleAvatar(
                        //   backgroundColor: Colors.black
                        // ),
                        title: Text(
                          event.activity,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text.rich(
                          TextSpan(
                            text: "Done at: " + event.timestamp.day.toString() + 
                                  "/" + event.timestamp.month.toString() + 
                                  "/" + event.timestamp.year.toString() +
                                  " @ " + event.timestamp.hour.toString() +
                                  ":" + event.timestamp.minute.toString() + 
                                  "\n",
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontSize: 13,
                            ),
                            children: <InlineSpan>[
                              TextSpan(text: "Emotion: " + event.emotion+"\n", style: TextStyle(fontFamily: 'Proxima Nova')),
                              TextSpan(text: "Your rating for this activity: " + event.activityRate.toString()+"\n", style: TextStyle(fontFamily: 'Proxima Nova'))
                            ]
                          ),
                        ),
                      ),
                    ),
              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
          )
        )
        
        )
        .toList(),
    );
  }

}