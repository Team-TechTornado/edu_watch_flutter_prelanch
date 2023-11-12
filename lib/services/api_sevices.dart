import 'dart:convert';
import 'package:edu_watch/models/id_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class idService {
  // Define Service class here
  // You need to define the properties based on your JSON structure
}

class ApiService {
  static const String baseUrl = "https://edu-watch.fly.dev/users/";

  static Future<String> getId(String phoneNumber) async {
    int.parse(phoneNumber);
    final url = Uri.parse("$baseUrl/$phoneNumber");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final ids = jsonDecode(response.body);
        return ids._id;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      rethrow; // Re-throw the error if needed for further handling
    }
  }
}
