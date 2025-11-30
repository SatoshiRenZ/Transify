import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../template/template.dart';
import '../../styles/style.dart';
import '../../providers/order_provider.dart';
import '../../models/model_order.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  int currentIndex = 2; // History page is at index 2

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
      child: buildHistoryContent(),
    );
  }

  Widget buildHistoryContent() {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.orders;

        if (orders.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 100,
                    color: AppColors.mainText.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Belum Ada Riwayat Pesanan',
                    style: AppTextStyles.mainFont25.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Pesanan tiket Anda akan muncul di sini',
                    style: AppTextStyles.mainFont15.copyWith(
                      color: AppColors.mainText.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/order');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Pesan Tiket Sekarang',
                      style: AppTextStyles.mainFont15.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat Pesanan',
                style: AppTextStyles.mainFont35.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${orders.length} Tiket',
                style: AppTextStyles.mainFont15.copyWith(
                  color: AppColors.mainText.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _buildTicketCard(order);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTicketCard(OrderModel order) {
    final formatTanggal = DateFormat('dd MMM yyyy', 'id');
    final formatTanggalPesan = DateFormat('dd MMM yyyy HH:mm', 'id');

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.box,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainText.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.confirmation_number,
                  color: AppColors.mainText,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.nomorTicket,
                        style: AppTextStyles.mainFont20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Dipesan: ${formatTanggalPesan.format(order.tanggalPesan)}',
                        style: AppTextStyles.mainFont15.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'GRATIS',
                    style: AppTextStyles.mainFont15.copyWith(
                      fontSize: 12,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.route,
                  label: 'Rute',
                  value: order.rute,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Tanggal',
                  value: formatTanggal.format(order.tanggal),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.access_time,
                  label: 'Waktu',
                  value: order.waktu,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.directions_bus,
                  label: 'Bus',
                  value: order.nomorBus,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.mainFont15.copyWith(
                  fontSize: 12,
                  color: AppColors.mainText.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: AppTextStyles.mainFont15.copyWith(
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
