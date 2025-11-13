import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required String name,
    required DateTime date,
    required String venue,
    required String city,
    required String ticketUrl,
  }) : super(
         name: name,
         date: date,
         venue: venue,
         city: city,
         ticketUrl: ticketUrl,
       );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final dates =
        json['dates']?['start']?['localDate'] ?? DateTime.now().toString();
    final venues = json['_embedded']?['venues'];
    final venueName = (venues != null && venues.isNotEmpty)
        ? venues[0]['name']
        : 'Local a confirmar';
    final cityName = (venues != null && venues.isNotEmpty)
        ? venues[0]['city']['name']
        : '';

    return EventModel(
      name: json['name'] ?? 'Evento',
      date: DateTime.tryParse(dates) ?? DateTime.now(),
      venue: venueName,
      city: cityName,
      ticketUrl: json['url'] ?? '',
    );
  }
}
