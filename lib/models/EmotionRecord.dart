import 'package:meta/meta.dart';

class EmotionRecord{
  String emotion;
  String activity;
  int activityRate;
  DateTime timestamp;

  EmotionRecord({
    @required this.emotion,
    @required this.activity,
    @required this.activityRate,
    @required this.timestamp
  });

  factory EmotionRecord.fetchRecord(Map<String, dynamic> snapshotData) {
    return EmotionRecord(
      emotion: snapshotData['emotion'],
      activity: snapshotData['activity'],
      activityRate: snapshotData['activityRate'],
      timestamp: snapshotData['timestamp'],
    );
  }

  Map<String, dynamic> getRecord() => {
      'emotion' : this.emotion,
      'activity': this.activity,
      'activityRate' : this.activityRate,
  };
}