import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../template/template.dart';
import '../../styles/style.dart';
import 'dart:convert';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  int currentIndex = 1;

  // Variabel untuk menampung data
  List<dynamic> jadwal = [];
  List<String> rute = [];
  String? rutePilihan;
  String? waktuPilihan;
  DateTime? tanggalPilihan;
  List<Map<String, dynamic>> waktuTersedia = [];

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  Future<void> loadJadwal() async {
    final String response = await rootBundle.loadString('asset/jadwal.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      jadwal = data;
      rute = data.map((item) => item['route'].toString()).toSet().toList();
    });
  }

  // Fungsi untuk memilih rute
  void onRouteSelected(String? route) {
    setState(() {
      rutePilihan = route;
      waktuPilihan = null;

      if (route != null) {
        waktuTersedia = jadwal
            .where((item) => item['route'] == route)
            .map((item) => {'name': item['name'], 'time': item['time']})
            .toList();

        // Filter waktu jika tanggal sudah dipilih
        filterWaktu();
      } else {
        waktuTersedia = [];
      }
    });
  }

  Future<void> pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalPilihan ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.secondary,
              onPrimary: AppColors.mainText,
              surface: AppColors.box,
              onSurface: AppColors.mainText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != tanggalPilihan) {
      setState(() {
        tanggalPilihan = picked;
        if (rutePilihan != null) {
          onRouteSelected(rutePilihan);
        }
      });
    }
  }

  // Fungsi untuk filter jam bus
  void filterWaktu() {
    if (tanggalPilihan != null) {
      final now = DateTime.now();
      final today =
          tanggalPilihan!.year == now.year &&
          tanggalPilihan!.month == now.month &&
          tanggalPilihan!.day == now.day;

      if (today) {
        final waktuSekarang = TimeOfDay.now();
        waktuTersedia = waktuTersedia.where((schedule) {
          final jam = schedule['time'].toString().split(':');
          if (jam.length == 2) {
            final hour = int.tryParse(jam[0]) ?? 0;
            final minute = int.tryParse(jam[1]) ?? 0;

            // Compare with current time
            if (hour > waktuSekarang.hour) {
              return true;
            } else if (hour == waktuSekarang.hour &&
                minute > waktuSekarang.minute) {
              return true;
            }
            return false;
          }
          return true;
        }).toList();
      }
    }
  }

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
      child: buildOrderContent(),
    );
  }

  Widget buildOrderContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pilih Jadwal Keberangkatan', style: AppTextStyles.title),
          const SizedBox(height: 30),

          // Memilih Rute Bus
          Text('Pilih Rute Keberangkatan', style: AppTextStyles.mainFont20),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: AppColors.box,
              border: Border.all(color: AppColors.secondary, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: rutePilihan,
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Pilih Rute Bus',
                    style: AppTextStyles.mainFont15.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),

                icon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.arrow_drop_down, color: AppColors.mainText),
                ),

                style: AppTextStyles.mainFont15,
                items: rute.map((String route) {
                  return DropdownMenuItem<String>(
                    value: route,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(route),
                    ),
                  );
                }).toList(),
                onChanged: onRouteSelected,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Memilih Tanggal Keberangkatan
          Text('Pilih Tanggal Keberangkatan', style: AppTextStyles.mainFont20),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: () => pilihTanggal(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.box,
                border: Border.all(color: AppColors.secondary, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tanggalPilihan == null
                        ? 'Pilih Tanggal Pemesanan Tiket'
                        : '${tanggalPilihan!.day.toString().padLeft(2, '0')}/${tanggalPilihan!.month.toString().padLeft(2, '0')}/${tanggalPilihan!.year}',
                    style: tanggalPilihan == null
                        ? AppTextStyles.mainFont15.copyWith(color: Colors.grey)
                        : AppTextStyles.mainFont15,
                  ),
                  Icon(Icons.calendar_today, color: AppColors.mainText),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Memilih Jam Keberangkatan
          Text('Pilih Jam keberangkatan', style: AppTextStyles.mainFont20),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.box,
              border: Border.all(
                color: rutePilihan == null ? Colors.grey : AppColors.secondary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: waktuPilihan,
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    rutePilihan == null
                        ? 'Mohon Pilih Rute Terlebih Dahulu'
                        : 'Pilih Jam Keberangkatanmu',
                    style: AppTextStyles.mainFont15.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.arrow_drop_down, color: AppColors.mainText),
                ),
                style: AppTextStyles.mainFont15,
                items: waktuTersedia.map((schedule) {
                  return DropdownMenuItem<String>(
                    value: schedule['time'],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('${schedule['name']} - ${schedule['time']}'),
                    ),
                  );
                }).toList(),
                onChanged: rutePilihan == null
                    ? null
                    : (String? value) {
                        setState(() {
                          waktuPilihan = value;
                        });
                      },
              ),
            ),
          ),

          // Tombol Order Tiket
          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Function will be added later
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Order Now',
                style: AppTextStyles.mainFont25.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
