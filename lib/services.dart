import 'dart:convert';
import 'package:countries/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://restcountries.com/v3.1/all';

  Future<List<Country>> getCountries() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // ignore: unnecessary_null_comparison
        if (data != null && data.isNotEmpty) {
          return data.map((json) => Country.fromJson(json)).toList();
        } else {
          throw Exception('No data available');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
