import '../../domain/entities/event_entity.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/artist_repository.dart';
import '../datasources/ticketmaster_datasource.dart';
import '../datasources/youtube_datasource.dart';

class ArtistRepositoryImpl implements ArtistRepository {
  final YoutubeDataSource youtubeDataSource;
  final TicketmasterDataSource ticketmasterDataSource;

  ArtistRepositoryImpl({
    required this.youtubeDataSource,
    required this.ticketmasterDataSource,
  });

  @override
  Future<List<VideoEntity>> getArtistVideos(String artistName) async {
    return await youtubeDataSource.searchVideos(artistName);
  }

  @override
  Future<List<EventEntity>> getArtistEvents(String artistName) async {
    return await ticketmasterDataSource.searchEvents(artistName);
  }
}
