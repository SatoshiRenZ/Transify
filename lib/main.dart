import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart'; 

import 'theme.dart';
import 'schedule.dart'; 

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  
  try
  {
    await initializeDateFormatting('id', null);
  }
  catch (e)
  {
    print("Error initializing : $e");
  }
  
  runApp(const MyApp());
}

// --- Main Application Widget ---

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transify',
      
      // --- LOCALIZATION CONFIGURATION START ---
      localizationsDelegates: const
      [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const
      [
        Locale('en', ''), 
        Locale('id', ''),
      ],
      // --- LOCALIZATION CONFIGURATION END ---
      
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        primaryColor: AppColors.primary,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.mainFont15.copyWith(color: AppColors.mainText),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// --- Home Page Widget ---

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  int _currentIndex = 0;
  List<UpcomingSchedule> _availableSchedules = [];
  bool _isLoading = true;

  @override
  void initState()
  {
    super.initState();
    _loadAvailableSchedules();
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

        // Calculate today's departure time
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
      // Sort the generated schedules by departure time (earliest first)
      generatedSchedules.sort((a, b) => a.departure.compareTo(b.departure));
      
      // 5. Take only the next 5 upcoming schedules to display
      final List<UpcomingSchedule> nextFive = generatedSchedules.take(5).toList();

      setState(()
      {
        _availableSchedules = nextFive;
        _isLoading = false;
      });
    }
    catch (e)
    {
      // Handle errors during loading or parsing
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

  String _getDestination(String route)
  {
    final parts = route.split(' - ');
    return parts.length > 1 ? parts.last : route;
  }

  @override
  Widget build(BuildContext context)
  {
    Intl.defaultLocale = 'id'; 
    final today = DateTime.now();
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            boxShadow:
            [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: const Offset(0, 2), 
              ),
            ],
          ),
          child: Center(
            child: Text("Transify", style: AppTextStyles.title),
          ),
        ),
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(color: AppColors.secondary))
        : SingleChildScrollView(
            child: Padding(
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

                  Container(
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
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "No available bus schedules remaining for today.",
                              style: AppTextStyles.mainFont20.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                        else
                        ..._availableSchedules.map((schedule)
                        {
                          return Column(
                            children: [
                              _busSchedule(schedule),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ]
                    )
                  )
                ],
              ),
            ),
          ),
      bottomNavigationBar: _navbar(),
    );
  }

  /// Builds a single reusable schedule item card using data from UpcomingSchedule.
  Widget _busSchedule(UpcomingSchedule schedule) {
    return Container(
      padding: const EdgeInsets.all(4.0), 
      decoration: BoxDecoration(
        color: AppColors.box,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow:
        [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
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

          // Display keterangan bis
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

  Widget _navbar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(index: 0, iconData: AppIcons.home),
          _buildNavItem(index: 1, iconData: AppIcons.ticket),
          _buildNavItem(index: 2, iconData: AppIcons.history),
          _buildNavItem(index: 3, iconData: AppIcons.profile),
        ],
      ),
    );
  }

  /// Builds a single item for the bottom navigation bar.
  Widget _buildNavItem({required int index, required IconData iconData}) {
    final bool isSelected = (_currentIndex == index);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          height: 70,
          color: isSelected ? AppColors.hover : AppColors.secondary, // <-- USER'S COLORS
          child: Center(
            child: Icon(
              iconData,
              size: 30,
              color: AppColors.mainText,
            ),
          ),
        ),
      ),
    );
  }
}