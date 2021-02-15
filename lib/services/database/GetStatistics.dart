import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:intl/intl.dart';

class GetStatistics
{
  User firebaseUser;
  int frequency;

  GetStatistics({this.firebaseUser,this.frequency});
  // 0 - today
  // 1 - week
  // 2 - month
  // 3 - year
  
  CollectionReference cr = FirebaseFirestore.instance.collection('Basic Info');
  
  // FOR EMOTION RECORD
  String activity;
  int activityRate;
  String emotion;
  Timestamp ts;
  List listOfData = [];
  List listOfEmotions = [];

  // Use getter methods
  static String mostFeltEmotion;
  static String averageTime;
  static int averageSatisfaction;
  static int numberOfTimes;

  List listOfLog = [];

  // FOR LOG RECORD
  

  Future<void> getData() async
  {
    //EMOTION RECORD
    QuerySnapshot snapshot = await cr.doc(firebaseUser.email).collection("emotion_record").get();
    
    //LOG
    QuerySnapshot snapshotlog = await cr.doc(firebaseUser.email).collection("Log").get();

    //GETTING THE DATE TODAY
    DateTime theDateToday = new DateTime.now();
    String currentMonth = DateFormat.M().format(theDateToday);
    String currentDay = DateFormat.d().format(theDateToday);
    String currentYear = DateFormat.y().format(theDateToday);
    int currentWeek = weekNumber(theDateToday);
    print("Current Week: $currentWeek");
    
    //FETCHING ALL DATA OF EMOTION RECORD
    snapshot.docs.map((e){
      Map temporaryMap;
      activity = e.data()["activity"];
      activityRate = e.data()["activityRate"];
      emotion = e.data()["emotion"];
      ts = e.data()["timestamp"];
      temporaryMap = {"Activity":activity,"Activity Rate":activityRate,"Emotion":emotion,"Timestamp":ts};

      //Preparting Date for Frequency Check
      DateTime theDateFetched = ts.toDate();
      String fetchedMonth = DateFormat.M().format(theDateFetched);
      String fetchedDay = DateFormat.d().format(theDateFetched);
      String fetchedYear = DateFormat.y().format(theDateFetched);
      int fetchedWeek = weekNumber(theDateFetched);
      
      //FILTERING OF FREQUENCY
      if(frequency==0)
      {
        if(fetchedMonth==currentMonth && fetchedDay==currentDay && fetchedYear==currentYear)
        {
          listOfData.add(temporaryMap);
        }
      }
      else if(frequency==1)
      {
        if(currentWeek==fetchedWeek)
        {
          listOfData.add(temporaryMap);
        }
      }
      else if(frequency==2)
      {
        if(fetchedMonth==currentMonth && fetchedYear==currentYear)
        {
          listOfData.add(temporaryMap);
        }
      }
      else if(frequency==3)
      {
        if(fetchedYear==currentYear)
        {
          listOfData.add(temporaryMap);
        }
      }
    }).toList();

    //FETCHING ALL DATA OF LOG
    snapshotlog.docs.map((e){
      DateTime logdate = e.data()["Timestamp"].toDate();

      String logfetchedMonth = DateFormat.M().format(logdate);
      String logfetchedDay = DateFormat.d().format(logdate);
      String logfetchedYear = DateFormat.y().format(logdate);
      int logfetchedWeek = weekNumber(logdate);

      //FILTERING OF FREQUENCY
      if(frequency==0)
      {
        if(logfetchedMonth==currentMonth && logfetchedDay==currentDay && logfetchedYear==currentYear)
        {
          listOfLog.add(logdate);
        }
      }
      else if(frequency==1)
      {
        if(logfetchedWeek==currentWeek)
        {
          listOfLog.add(logdate);
        }
      }
      else if(frequency==2)
      {
        if(logfetchedMonth==currentMonth && logfetchedYear==currentYear)
        {
          listOfLog.add(logdate);
        }
      }
      else if(frequency==3)
      {
        if(logfetchedYear==currentYear)
        {
          listOfLog.add(logdate);
        }
      }
    }).toList();

    //MOST FELT EMOTION
    for(var x in listOfData)
    {
      listOfEmotions.add(x["Emotion"]);
    }
    mostFeltEmotion = MostFeltEmotion(listOfEmotions);
    //print("Most Felt Emotion is $mostFeltEmotion");

    //AVERAGE TIME OF MOST FELT EMOTION
    averageTime = averageTimeOfEmotion(listOfData);
    //print("Average Time You Felt $mostFeltEmotion: $averageTime");

    //NUMBER OF TIMES APP WERE OPENED
    numberOfTimes = openedTheAppForNTimes(listOfLog);
    //print("You opened this app $numberOfTimes times already");

    //AVERAGE SATISFACTION PER ACTIVITY
    averageSatisfaction = calculateAverageSatisfaction(listOfData);
    //print("The average satisfaction per activity is $averageSatisaction");
  }

  // USED BY "averageTimeOfEmotion"
  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  // USED FOR CALCULATING THE WEEK NUMBER
  int numOfWeeks(int year) 
  {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  int weekNumber(DateTime date) 
  {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy =  ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  // METHOD 1: 
  String MostFeltEmotion(listOfEmotions)
  {
    try
    {
      Map map = new SortedMap(Ordering.byValue());
      List emotions = [];

      listOfEmotions.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));  

      for(var x in map.keys)
      {
        emotions.add(x);
      }
      return emotions.last;
    } catch (e){
      return "None";
    }
  }

  // METHOD 2: 
  String averageTimeOfEmotion(listOfData)
  {
    try
    {
      int totalMinutes = 0;
      int count = 0;
      for(var x in listOfData)
      {
        Timestamp myTimeStamp = x["Timestamp"];
        DateTime myDateTime = myTimeStamp.toDate();
        String hours = DateFormat.H().format(myDateTime);
        String minute = DateFormat.m().format(myDateTime);
        int hoursToMinute = int.parse(hours)*60;
        int minuteToMinute = int.parse(minute);
        totalMinutes = totalMinutes+hoursToMinute+minuteToMinute;
        count = count+1;
      }
      
      String averageTime;
      int averageMinutes = (totalMinutes/count).round();
      if(averageMinutes>720)
      {
        averageMinutes = averageMinutes - 720;
        averageTime = durationToString(averageMinutes) + " pm";
      }
      else
      {
        averageTime = durationToString(averageMinutes) + " am";
      }
      
      return averageTime;
    } catch (e) {
      return "None";
    }
  }

  // METHOD 3:
  int openedTheAppForNTimes(listOfLog)
  {
    int ctr = 0;
    for(var x in listOfLog)
    {
      ctr = ctr+1;
    }
    return ctr;
  }

  // METHOD 4
  int calculateAverageSatisfaction(listOfData)
  {
    try
    {  
      int rate;
      int totalRate = 0;
      int ctr = 0;
      int average;

      for(var x in listOfData)
      {
        rate = x["Activity Rate"];
        totalRate = totalRate+rate;
        ctr = ctr+1;
      }
      average = (totalRate/ctr).round();

      return average;
    } catch (e) {
      return 0;
    }
  }
}