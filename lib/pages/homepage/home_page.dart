import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:transify/pages/homepage/schedule.dart';

import '../../template/template.dart'; 
import '../../styles/style.dart'; 

class HomePage extends StatefulWidget
{
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
{
  int currentIndex = 0; 
  
  List<UpcomingSchedule> _availableSchedules = [];
  bool _isLoading = true;

  @override
  void initState()
  {
    super.initState();
    _loadAvailableSchedules(); 
  }

  void onItemTapped(int index)
  {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    String destRoute;
    switch (index)
    {
      case 0:
        destRoute = '/home';
        break;
      case 1:
        destRoute = '/order';
        break;
      case 2:
        destRoute = '/history';
        break;
      case 3:
        destRoute = '/profile';
        break;
      default:
        return;
    }

    if (currentRoute != destRoute)
    {
      Navigator.pushReplacementNamed(context, destRoute);
    }
    else
    {
      setState(()
      {
        currentIndex = index;  
      });
    }
  }

  Future<void> _loadAvailableSchedules() async
  {
    try
    {
      final String jsonString = await rootBundle.loadString('asset/jadwal.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<Schedule> dailySchedules = jsonList
          .map((json) => Schedule.fromJson(json))
          .toList();

      final DateTime now = DateTime.now();
      final List<UpcomingSchedule> generatedSchedules = [];

      for (var dailySchedule in dailySchedules)
      {
        final parts = dailySchedule.time.split(':'); 
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        DateTime departureTime = DateTime(now.year, now.month, now.day, hour, minute);

        if (departureTime.isAfter(now))
        {
            generatedSchedules.add(UpcomingSchedule(
              route: dailySchedule.route,
              name: dailySchedule.name, 
              departure: departureTime, 
            ));
        }
      }
      generatedSchedules.sort((a, b) => a.departure.compareTo(b.departure));

      setState(()
      {
        _availableSchedules = generatedSchedules;
        _isLoading = false;
      });
    }
    catch (e)
    {
      print("Error loading bus schedule: $e");
      setState(()
      {
        _isLoading = false;
      });
    }
  }

  String _formatFullDate(DateTime date)
  {
    final dayOfWeek = DateFormat('EEEE', 'id').format(date); 
    final dateFormatted = DateFormat('d MMMM yyyy', 'id').format(date);
    return '${dayOfWeek[0].toUpperCase()}${dayOfWeek.substring(1)}, $dateFormatted';
  }

  Widget _busSchedule(UpcomingSchedule schedule)
  {
    return Container(
      padding: const EdgeInsets.all(4.0), 
      decoration: BoxDecoration(
        color: AppColors.box,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.mainText,
          width: 1.0
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children:
        [
          Icon(
            AppIcons.bus, 
            size: 50,
            color: AppColors.mainText,
          ),
          const SizedBox(width: 5),

          Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  schedule.name,
                  style: AppTextStyles.mainFont20, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  schedule.route,
                  style: AppTextStyles.mainFont15, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Keberangkatan pukul ${DateFormat('HH:mm').format(schedule.departure)}', 
                  style: AppTextStyles.mainFont15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return TemplatePage(
      currentIndex: currentIndex,
      onIndexChanged: onItemTapped,
      child: buildHomeContent(),
    );
  }
  
  Widget buildHomeContent()
  {
    final today = DateTime.now();

    return _isLoading
      ? const Center(child: CircularProgressIndicator(color: AppColors.secondary))
      : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text("Welcome!", style: AppTextStyles.mainFont35),
                Text("Get your own ticket now!", style: AppTextStyles.mainFont20.copyWith(fontWeight: FontWeight.normal)),
                const SizedBox(height: 5),
                Text(
                  _formatFullDate(today), 
                  style: AppTextStyles.mainFont20.copyWith(fontSize: 18, color: AppColors.mainText),
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.box,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow:
                      [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Jadwal Bis", style: AppTextStyles.mainFont20),
                        const SizedBox(height: 15),

                        if (_availableSchedules.isEmpty)
                        Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "No available bus schedules remaining for today.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.mainFont20.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      )
                        else
                        Expanded( 
                        child: ListView.separated(
                          itemCount: _availableSchedules.length, 
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final schedule = _availableSchedules[index];
                            return _busSchedule(schedule);
                          },
                        ),
                      ),
                      ]
                    )
                  )
                )
              ],
            ),
        );
  }
}