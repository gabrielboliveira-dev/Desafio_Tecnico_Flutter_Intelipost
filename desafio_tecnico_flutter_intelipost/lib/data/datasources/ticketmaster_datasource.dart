import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../models/event_model.dart';

class TicketmasterDataSource {
  final http.Client client;
  TicketmasterDataSource({required this.client});

  Future<List<EventModel>> searchEvents(String keyword) async {
    final uri = Uri.parse(
      '${ApiConstants.ticketmasterBaseUrl}/events.json?keyword=$keyword&apikey=${ApiConstants.ticketmasterApiKey}&size=10&sort=date,asc',
    );
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['_embedded'] == null) return [];

      final List events = data['_embedded']['events'];
      return events.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro Ticketmaster: ${response.statusCode}');
    }
  }
}
