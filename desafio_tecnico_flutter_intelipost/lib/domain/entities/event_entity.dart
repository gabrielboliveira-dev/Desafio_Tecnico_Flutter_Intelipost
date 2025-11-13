class EventEntity {
  final String name;
  final DateTime date;
  final String venue;
  final String city;
  final String ticketUrl;

  EventEntity({
    required this.name,
    required this.date,
    required this.venue,
    required this.city,
    required this.ticketUrl,
  });
}
