import '../../domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required String id,
    required String title,
    required String thumbnailUrl,
  }) : super(id: id, title: title, thumbnailUrl: thumbnailUrl);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']['videoId'] ?? '';
    final snippet = json['snippet'];
    return VideoModel(
      id: id,
      title: snippet['title'] ?? 'Sem título',
      thumbnailUrl: snippet['thumbnails']['high']['url'] ?? '',
    );
  }
}
