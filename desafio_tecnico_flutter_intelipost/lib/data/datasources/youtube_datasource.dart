import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../models/video_model.dart';

class YoutubeDataSource {
  final http.Client client;
  YoutubeDataSource({required this.client});

  Future<List<VideoModel>> searchVideos(String query) async {
    final uri = Uri.parse(
      '${ApiConstants.youtubeBaseUrl}/search?part=snippet&type=video&q=$query&key=${ApiConstants.youtubeApiKey}&maxResults=5',
    );
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'];
      return items.map((e) => VideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro YouTube: ${response.statusCode}');
    }
  }
}
