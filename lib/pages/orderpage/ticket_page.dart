import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../styles/style.dart';
import '../../models/model_order.dart';
import 'dart:math';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  // Generate Nomor Tiket
  String generatenomorTicket() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNum = random.nextInt(9999);
    return 'TRF${timestamp.toString().substring(7)}$randomNum';
  }  

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final nomorTicket = generatenomorTicket();
    final formatTanggal = DateFormat('dd MMMM yyyy', 'id');

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Icon Centang Hijau
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                // Pesan Pesanan Berhasil
                // Tittle
                Text(
                  'Pemesanan Berhasil!',
                  style: AppTextStyles.title.copyWith(fontSize: 32),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Tiket Bus Anda Telah Berhasil Dipesan',
                  style: AppTextStyles.mainFont20,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Ticket Card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.box,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Ticket Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_bus,
                                  size: 40,
                                  color: AppColors.mainText,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'TRANSIFY',
                                  style: AppTextStyles.mainFont35.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'E-TICKET BUS GRATIS',
                              style: AppTextStyles.mainFont15.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Ticket Body
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Nomor Ticket
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'No. Tiket: $nomorTicket',
                                style: AppTextStyles.mainFont20.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Detail Ticket
                            // Rute
                            _buildTicketRow(
                              icon: Icons.route,
                              label: 'Rute',
                              value: order.rute,
                            ),
                            const Divider(height: 30),

                            // Tanggal
                            _buildTicketRow(
                              icon: Icons.calendar_today,
                              label: 'Tanggal',
                              value: formatTanggal.format(order.tanggal),
                            ),
                            const Divider(height: 30),

                            // Waktu
                            _buildTicketRow(
                              icon: Icons.access_time,
                              label: 'Waktu',
                              value: order.waktu,
                            ),
                            const Divider(height: 30),

                            // Nomor Bus
                            _buildTicketRow(
                              icon: Icons.directions_bus,
                              label: 'Bus',
                              value: order.nomorBus,
                            ),
                            const SizedBox(height: 25),

                            // Icon Centang
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                border: Border.all(
                                  color: Colors.green.shade600,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: Colors.green.shade600,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'GRATIS - Rp 0',
                                    style: AppTextStyles.mainFont20.copyWith(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomPaint(
                        size: const Size(double.infinity, 1),
                        painter: DashedLinePainter(),
                      ),

                      // Footer Ticket
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Tunjukkan tiket ini kepada petugas saat naik bus',
                              style: AppTextStyles.mainFont15.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Harap datang 10 menit sebelum keberangkatan',
                              style: AppTextStyles.mainFont15.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Button Navigasi
                // Button Ke Beranda
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.box,
                          foregroundColor: AppColors.mainText,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: AppColors.secondary,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Ke Beranda',
                          style: AppTextStyles.mainFont20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Button Ke Riwayat
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/history');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Ke Riwayat',
                          style: AppTextStyles.mainFont20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.mainFont15.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.mainFont20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Garis Putus-Putus Pembatas
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
