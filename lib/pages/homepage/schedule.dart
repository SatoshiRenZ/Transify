class Schedule
{
  final String route;
  final String name;
  final String time;

  Schedule(
  {
    required this.route,
    required this.name,
    required this.time,
  });

  factory Schedule.fromJson(Map<String, dynamic> json)
  {
    return Schedule(
      route: json['route'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
    );
  }
}

class UpcomingSchedule
{
  final String route;
  final String name;
  final DateTime departure;

  UpcomingSchedule(
  {
    required this.route,
    required this.name,
    required this.departure,
  });
}