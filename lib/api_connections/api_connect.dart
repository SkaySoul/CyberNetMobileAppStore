import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/cart.dart';
import '../models/order.dart';
import '../models/product/category.dart';
import '../models/product/fullproduct.dart';
import '../models/product/product.dart';
import '../models/product/subcategory.dart';
import '../models/userdata/shipping_address.dart';
import '../models/userdata/user.dart';



class APIConnect{
  static const hostConnect = "http://192.168.1.26:8090/api/v1";
  static const registerUrl = "$hostConnect/auth/register";
  static const loginUrl = "$hostConnect/auth/login";
  static const meUrl = "$hostConnect/users/me";
  static const productsUrl = "$hostConnect/products";
  static const categoryUrl = "$hostConnect/categories";
  static const subcategoryUrl = "$hostConnect/subcategories";
  static const imagesBaseUrl  = '$hostConnect/api/v1/images';
  static const cartUrl = "$hostConnect/cart";
  static const ordersUrl = '$hostConnect/orders';
  static const addressesUrl = '$hostConnect/addresses';
  static String? basicAuthHeader;

  static Future<bool> register({
    required String login,
    required String password,
    required String email,
    required String phone,
    required String name,
    required String surname,
  }) async {
    final Map<String, dynamic> body = {
      "username": login,
      "password": password,
      "email": email,
      "phone": phone,
      "name": name,
      "surname": surname,
    };

    try {
      final resp = await http.post(
        Uri.parse(registerUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return resp.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  static Map<String,String> _headers() {
    final headers = {'Content-Type': 'application/json'};
    if (basicAuthHeader != null) {
      headers['Authorization'] = basicAuthHeader!;
    }
    return headers;
  }

  static Future<bool> login({required String login, required String password}) async {
    final credentials = base64Encode(utf8.encode("$login:$password"));
    try {
      final resp = await http.get(Uri.parse(loginUrl), headers: {"Authorization": "Basic $credentials"});
      return resp.statusCode == 200;
    } catch (e, st) {
      debugPrint('Login error: $e\\n$st');
      return false;
    }
  }

  static Future<bool> getUser() async {
    try {
      final resp = await http.get(Uri.parse(meUrl), headers: _headers());
      return resp.statusCode == 200;
    } catch (e, st) {
      debugPrint('Login error: $e\\n$st');
      return false;
    }
  }

  static Future<UserDTO> getUserData() async {
      final resp = await http.get(Uri.parse(meUrl), headers: _headers());
      if (resp.statusCode != 200) {
        throw Exception('Failed to load user: ${resp.statusCode}');
      }
      return UserDTO.fromJson(jsonDecode(resp.body));
  }

  static Future<List<ProductDTO>> getAllProducts() async {
    final resp = await http.get(
      Uri.parse(productsUrl),
      headers: _headers(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to load products: ${resp.statusCode}');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => ProductDTO.fromJson(e)).toList();
  }


  static Future<ProductDTO> getProductById({required int productId}) async {
    final resp = await http.get(
      Uri.parse('$productsUrl/$productId'),
      headers: _headers(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to load product $productId: ${resp.statusCode}');
    }
    return ProductDTO.fromJson(jsonDecode(resp.body));
  }


  static Future<List<ProductDTO>> getByCategory({required int categoryId}) async {
    final resp = await http.get(
      Uri.parse('$categoryUrl/$categoryId'),
      headers: _headers(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to load category $categoryId: ${resp.statusCode}');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => ProductDTO.fromJson(e)).toList();
  }

  static Future<List<ProductDTO>> getBySubcategory({required int subcategoryId}) async {
    final resp = await http.get(
      Uri.parse('$subcategoryUrl/$subcategoryId'),
      headers: _headers(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to load subcategory $subcategoryId: ${resp.statusCode}');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => ProductDTO.fromJson(e)).toList();
  }
  static Future<List<CategoryDTO>> getCategories() async {
    final resp = await http.get(Uri.parse(categoryUrl), headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Failed to load categories (${resp.statusCode})');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => CategoryDTO.fromJson(e)).toList();
  }
  static Future<CategoryDTO> getCategory({required int id }) async {
    final resp = await http.get(Uri.parse('$categoryUrl/$id'), headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Failed to load category (${resp.statusCode})');
    }
    final Map<String, dynamic> json = jsonDecode(resp.body);
    return CategoryDTO.fromJson(json);
  }
  static Future<SubcategoryDTO> getSubcategory({required int id }) async {
    final resp = await http.get(Uri.parse('$subcategoryUrl/$id'), headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Failed to load subcategory (${resp.statusCode})');
    }
    final Map<String, dynamic> json = jsonDecode(resp.body);
    return SubcategoryDTO.fromJson(json);
  }

  static Future<List<SubcategoryDTO>> getSubcategories() async {
    final resp = await http.get(Uri.parse(subcategoryUrl), headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Failed to load subcategories (${resp.statusCode})');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => SubcategoryDTO.fromJson(e)).toList();
  }
  static Future<FullProductDTO> getFullProductById({ required int id }) async {
    final resp = await http.get(Uri.parse('$productsUrl/full/$id'), headers:  _headers());
    if (resp.statusCode != 200) {
      throw Exception('Failed to load full product ($id): ${resp.statusCode}');
    }
    final Map<String, dynamic> json = jsonDecode(resp.body);
    return FullProductDTO.fromJson(json);
  }

  static Future<void> addToCart(int productId, int quantity) async {
    final url = Uri.parse('$hostConnect/cart');
    final resp = await http.post(
      url,
      headers:  _headers(),
      body: jsonEncode({'productId': productId, 'quantity': quantity}),
    );
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('Failed to add to cart: ${resp.body}');
    }
  }

  static Future<List<CartItemDTO>> getCart() async {
    final url = Uri.parse('$hostConnect/cart');
    final resp = await http.get(url, headers:  _headers());
    if (resp.statusCode == 200) {
      final list = jsonDecode(resp.body) as List;
      return list.map((e) => CartItemDTO.fromJson(e)).toList();
    }
    throw Exception('Failed to load cart');
  }

  static Future<void> removeFromCart(int productId) async {
    final url = Uri.parse('$hostConnect/cart/$productId');
    final resp = await http.delete(url, headers:  _headers());
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('Failed to remove from cart');
    }
  }

  static Future<void> checkoutCart() async {
    final url = Uri.parse('$hostConnect/cart/checkout');
    final resp = await http.post(url, headers:  _headers());
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('Checkout failed');
    }
  }

  static Future<OrderDTO> getOrderById(int orderId) async {
    final url = Uri.parse('$ordersUrl/$orderId');
    final resp = await http.get(url, headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Cant load order: $orderId: ${resp.statusCode}');
    }
    return OrderDTO.fromJson(jsonDecode(resp.body));
  }

  static Future<OrderDTO> createOrder(OrderDTO order) async {
    final url = Uri.parse(ordersUrl);
    final resp = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(order.toJson()),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Error creating order: ${resp.body}, ${jsonEncode(order.toJson())}');
    }
    return OrderDTO.fromJson(jsonDecode(resp.body),);
  }

  static Future<OrderDTO> updateOrderStatus(int orderId, String status) async {
    final url = Uri.parse('$ordersUrl/$orderId/status');
    final resp = await http.put(
      url,
      headers: _headers(),
      body: jsonEncode({'status': status}),
    );
    if (resp.statusCode != 200) {
      throw Exception('Order update order: ${resp.statusCode}');
    }
    return OrderDTO.fromJson(jsonDecode(resp.body));
  }

  static Future<List<ShippingAddressDTO>> getAddresses() async {
    final url = Uri.parse(addressesUrl);
    final resp = await http.get(url, headers: _headers());
    if (resp.statusCode != 200) {
      throw Exception('Cant load addresses: ${resp.statusCode}');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList
        .map((e) => ShippingAddressDTO.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<ShippingAddressDTO> addAddress(
      ShippingAddressDTO address) async {
    final url = Uri.parse(addressesUrl);
    final resp = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(address.toJson()),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Adding address error: ${resp.body}');
    }
    return ShippingAddressDTO.fromJson(jsonDecode(resp.body));
  }

  static Future<void> deleteAddress(int id) async {
    final url = Uri.parse('$addressesUrl/$id');
    final resp = await http.delete(url, headers: _headers());
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('Failed to delete address (${resp.statusCode})');
    }
  }

  static Future<ShippingAddressDTO> updateAddress(
      ShippingAddressDTO address) async {
    final url = Uri.parse('$addressesUrl/${address.id}');
    final resp = await http.put(
      url,
      headers: _headers(),
      body: jsonEncode(address.toJson()),
    );
    if (resp.statusCode != 200) {
      throw Exception('Order update error: ${resp.statusCode}');
    }
    return ShippingAddressDTO.fromJson(jsonDecode(resp.body));
  }

  static Future<List<OrderDTO>> fetchOrders() async {
    final resp = await http.get(
      Uri.parse(ordersUrl),
      headers: _headers(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to fetch orders: ${resp.statusCode}');
    }
    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => OrderDTO.fromJson(e)).toList();
  }

}