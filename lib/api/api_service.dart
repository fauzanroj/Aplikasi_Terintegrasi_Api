import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/models/user.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body)['data'];
      return list.map((model) => User.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      if (responseData != null && responseData['data'] != null) {
        return User.fromJson(responseData['data']);
      } else {
        throw Exception('Failed to create user: response data null');
      }
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }
}