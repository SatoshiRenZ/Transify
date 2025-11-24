import 'package:flutter/material.dart';
import '../template/template.dart';
import '../styles/style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  int currentIndex = 2; // Karena ini halaman History, index bottom bar-nya adalah 2

  void onItemTapped(int index) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    String destinationRoute;
    switch (index) {
      case 0:
        destinationRoute = '/home';
        break;
      case 1:
        destinationRoute = '/order';
        break;
      case 2:
        destinationRoute = '/history'; // Route untuk halaman ini
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
      child: buildHistoryContent(),
    );
  }

  Widget buildHistoryContent() {
    return Column(
      children: [
        // Header Section
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700), // Warna kuning keemasan
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Transify',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'History Transaction',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Look back into your past transactions.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Daftar Transaksi
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 4, // Jumlah transaksi contoh
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Ikon Bus
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.directions_bus,
                          color: Colors.blue[800],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Detail Transaksi
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grogol - Jonggol',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Selasa, 2 November 2025',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Keberangkatan pukul 01:00',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
