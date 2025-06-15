import 'package:cyber_net_application/views/account_details_screen.dart';
import 'package:cyber_net_application/views/address_selection_screen.dart';
import 'package:cyber_net_application/views/cartscreen.dart';
import 'package:cyber_net_application/views/delivery_method_screen.dart';
import 'package:cyber_net_application/views/homescreen.dart';
import 'package:cyber_net_application/views/loginscreen.dart';
import 'package:cyber_net_application/views/menuscreen.dart';
import 'package:cyber_net_application/views/order_details_screen.dart';
import 'package:cyber_net_application/views/order_history_screen.dart';
import 'package:cyber_net_application/views/payment_method_screen.dart';
import 'package:cyber_net_application/views/productdetails.dart';
import 'package:cyber_net_application/views/registrationformscreen.dart';
import 'package:cyber_net_application/views/review_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cyber Net',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterFormScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/product/:id',
          page: () {
            final idStr = Get.parameters['id'];
            final id = int.tryParse(idStr ?? '') ?? 0;
            return ProductDetailScreen(productId: id);
          },
        ),
        GetPage(name: '/cart',               page: () => const CartScreen()),
        GetPage(name: '/order/address',      page: () => AddressSelectionScreen()),
        GetPage(name: '/order/delivery',     page: () => DeliveryMethodScreen()),
        GetPage(name: '/order/payment',      page: () => PaymentMethodScreen()),
        GetPage(name: '/order/review',       page: () => ReviewOrderScreen()),
        GetPage(name: '/orders/history',     page: () => const OrderHistoryScreen()),
        GetPage(name: '/orders/:id',         page: () => const OrderDetailScreen()),
        GetPage(name: '/menu',               page: () => const MenuScreen()),
        GetPage(name: '/account',            page: () => const AccountDetailsScreen()),
      ],
    );
  }
}