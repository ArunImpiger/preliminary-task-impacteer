import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserRepository {
  final String baseUrl;

  UserRepository({required this.baseUrl});

  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(page>1) await Future.delayed(const Duration(seconds: 1));
      return (data['data'] as List).map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['data'];
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
