class VideoEntity {
  final String id;
  final String title;
  final String thumbnailUrl;

  String get videoUrl => 'https://www.youtube.com/watch?v=$id';

  VideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });
}
