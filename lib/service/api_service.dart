
import 'dart:convert';
import '../model/team_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.thesportsdb.com/api/v1';
  final String authBaseUrl = 'https://mediadwi.com/api/latihan';

  Future<List<TeamModel>> getTeamList() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/json/3/search_all_teams.php?l=English%20Premier%20League'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> teamData = data['teams'];
      return teamData.map((item) => TeamModel.fromJson(item)).toList();
    }
    throw Exception('Failed to load team ${response.statusCode}');
  }

  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    final Uri url = Uri.parse('$authBaseUrl/login');

    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to login ${response.statusCode}');
  }
}
