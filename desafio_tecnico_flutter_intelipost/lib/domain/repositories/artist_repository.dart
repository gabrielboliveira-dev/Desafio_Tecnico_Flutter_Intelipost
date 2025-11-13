import '../entities/event_entity.dart';
import '../entities/video_entity.dart';

abstract class ArtistRepository {
  Future<List<VideoEntity>> getArtistVideos(String artistName);
  Future<List<EventEntity>> getArtistEvents(String artistName);
}
