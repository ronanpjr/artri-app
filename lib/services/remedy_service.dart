import 'dart:convert';
import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/services/security_token_service.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:artriapp/utils/enums/security_tokens.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;

class RemedyService {
  final String baseUrl = Environment.apiUrl;
  final SecurityTokenService _tokenService = SecurityTokenService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _tokenService.getToken(SecurityToken.accessToken);
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<Remedy>> getRemedies() async {
    final headers = await _authHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/remedies/'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar medicamentos: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Remedy.fromMap(json)).toList();
  }

  Future<Remedy> createRemedy({
    required String name,
    required String description,
    required int quantity,
    required String hour,
    required DaysOfWeek dayOfWeek,
  }) async {
    final headers = await _authHeaders();
    final body = jsonEncode({
      'name': name,
      'description': description.isEmpty ? 'Sem descrição' : description,
      'quantity': quantity,
      'hour': hour,
      'days_of_week': dayOfWeek.apiValue,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/remedies/'),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 201) {
      final errorBody = response.body;
      throw Exception('Falha ao criar medicamento: ${response.statusCode} - $errorBody');
    }

    return Remedy.fromMap(jsonDecode(response.body));
  }

  Future<void> deleteRemedy(int id) async {
    final headers = await _authHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl/remedies/$id/'),
      headers: headers,
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Falha ao deletar medicamento: ${response.statusCode}');
    }
  }
}
