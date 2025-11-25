import 'package:flutter/material.dart';
import '../template/template.dart';
import '../styles/style.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  int currentIndex = 1; // Karena ini halaman Order/Jadwal

  void onItemTapped(int index) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    String destinationRoute;
    switch (index) {
      case 0:
        destinationRoute = '/home';
        break;
      case 1:
        destinationRoute = '/order'; // Route untuk halaman ini
        break;
      case 2:
        destinationRoute = '/history';
        break;
      case 3:
        destinationRoute = '/profile';
        break;
      default:
        return;
    }
    if (currentRoute != destinationRoute) {
      Navigator.pushReplacementNamed(context, destinationRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      currentIndex: currentIndex,
      onIndexChanged: onItemTapped,
      child: buildScheduleContent(),
    );
  }

  Widget buildScheduleContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Judul & Tujuan
          Text(
            'Jadwal Bis',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Tujuan akhir : ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
              _buildDestinationChip('PIK Avenue'),
              const SizedBox(width: 8),
              _buildDestinationChip('Tokyo Riverside'),
            ],
          ),
          const SizedBox(height: 20),
          // Daftar Jadwal
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final schedule = _getScheduleData(index);
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(
                      Icons.directions_bus,
                      color: Colors.blue[800],
                      size: 32,
                    ),
                    title: Text(
                      '${schedule['route']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    subtitle: Text(
                      'Keberangkatan pukul ${schedule['time']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.orange[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Map<String, String> _getScheduleData(int index) {
    final List<Map<String, String>> data = [
      {
        'route': 'Tokyo Riverside - PIK Avenue',
        'time': '20:40',
      },
      {
        'route': 'PIK Avenue - Tokyo Riverside',
        'time': '20:59',
      },
      {
        'route': 'Tokyo Riverside - PIK Avenue',
        'time': '21:00',
      },
      {
        'route': 'PIK Avenue - Tokyo Riverside',
        'time': '21:15', // Contoh tambahan
      },
    ];
    return data[index];
  }
}
