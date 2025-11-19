import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Mengatur font default agar mirip dengan style di gambar (Sans-serif rounded)
        fontFamily: 'Arial', 
        useMaterial3: true,
      ),
      home: const HistoryTransactionPage(),
    );
  }
}

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  // Index untuk Bottom Navigation Bar (Default ke 2: History)
  int _selectedIndex = 2;

  // Warna-warna utama berdasarkan gambar
  final Color primaryYellow = const Color(0xFFFFD54F); // Kuning header
  final Color backgroundCream = const Color(0xFFFFF8E1); // Latar belakang
  final Color textDarkBlue = const Color(0xFF1A237E); // Teks biru tua
  final Color activeNavColor = const Color(0xFFFFCA28); // Warna tombol aktif nav

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundCream,
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER (Bagian Kuning "Transify")
            Container(
              width: double.infinity,
              color: primaryYellow,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Transify',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textDarkBlue,
                    fontStyle: FontStyle.italic, // Meniru gaya logo
                    fontFamily: 'Serif', // Fallback agar terlihat beda
                  ),
                ),
              ),
            ),

            // 2. BODY CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Judul Halaman
                    Text(
                      'History Transaction',
                      style: TextStyle(
                        fontSize: 24,
                        color: textDarkBlue,
                        fontWeight: FontWeight.w600, // Semi-bold
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Subtitle
                    Text(
                      'Look back into your past transactions.',
                      style: TextStyle(
                        fontSize: 14,
                        color: textDarkBlue.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // List Transaksi
                    Expanded(
                      child: ListView.builder(
                        itemCount: 4, // Sesuai gambar ada 4 item
                        itemBuilder: (context, index) {
                          return _buildTransactionCard();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // 3. BOTTOM NAVIGATION BAR (Custom untuk meniru style gambar)
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: primaryYellow,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.store, 0),
            _buildNavItem(Icons.confirmation_number_outlined, 1),
            _buildNavItem(Icons.history, 2), // Ini yang aktif
            _buildNavItem(Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  // Widget untuk Kartu Transaksi
  Widget _buildTransactionCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikon Bus (Placeholder Gambar)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4C3), // Hijau muda background ikon
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_bus,
              color: Colors.blue[400],
              size: 35,
            ),
          ),
          const SizedBox(width: 15),
          // Detail Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grogol - Jonggol',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textDarkBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Selasa, 2 November 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: textDarkBlue,
                  ),
                ),
                Text(
                  'Keberangkatan pukul 07.00',
                  style: TextStyle(
                    fontSize: 12,
                    color: textDarkBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Item Navigasi Bawah
  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // Lingkaran oranye/putih di belakang ikon yang aktif
          color: isSelected ? Colors.orange[100] : Colors.transparent,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Icon(
          icon,
          size: 30,
          color: isSelected ? Colors.teal : Colors.grey[700], 
          // Warna icon teal/hijau tua saat aktif, abu saat tidak
        ),
      ),
    );
  }
}