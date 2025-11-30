import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model_order.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  static const String _storageKey = 'orders';

  List<OrderModel> get orders => _orders;
  int get orderCount => _orders.length;

  OrderProvider() {
    _loadOrders();
  }

  // load order dari storage sementara
  Future<void> _loadOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? ordersJson = prefs.getString(_storageKey);

      if (ordersJson != null && ordersJson.isNotEmpty) {
        try {
          final List<dynamic> ordersList = json.decode(ordersJson);
          _orders = ordersList
              .map((item) {
                try {
                  return OrderModel.fromMap(item as Map<String, dynamic>);
                } catch (e) {
                  if (kDebugMode) {
                    print('Error parsing individual order: $e');
                  }
                  return null;
                }
              })
              .whereType<OrderModel>()
              .toList();
          notifyListeners();
        } catch (e) {
          if (kDebugMode) {
            print('Error decoding orders JSON, clearing storage: $e');
          }
          // Clear corrupt data
          await prefs.remove(_storageKey);
          _orders = [];
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading orders: $e');
      }
      _orders = [];
    }
  }

  // simpan order ke storage sementara
  Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String ordersJson = json.encode(
        _orders.map((order) => order.toMap()).toList(),
      );
      await prefs.setString(_storageKey, ordersJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving orders: $e');
      }
    }
  }

  // menambahkan order baru
  Future<void> addOrder(OrderModel order) async {
    _orders.insert(0, order);
    notifyListeners();
    await _saveOrders();
  }

  // mendapatkan order berdasarkan ID
  OrderModel? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}
