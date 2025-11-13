import 'package:flutter/material.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/artist_repository.dart';

enum ViewState { initial, loading, success, error }

class ArtistProvider extends ChangeNotifier {
  final ArtistRepository repository;

  ArtistProvider({required this.repository});

  ViewState _state = ViewState.initial;
  List<VideoEntity> _videos = [];
  List<EventEntity> _events = [];
  String _errorMessage = '';
  String _currentArtist = '';

  ViewState get state => _state;
  List<VideoEntity> get videos => _videos;
  List<EventEntity> get events => _events;
  String get currentArtist => _currentArtist;
  String get errorMessage => _errorMessage;

  Future<void> searchArtist(String artistName) async {
    if (artistName.isEmpty) return;

    _currentArtist = artistName;
    _state = ViewState.loading;
    notifyListeners();

    try {
      final results = await Future.wait([
        repository.getArtistVideos(artistName),
        repository.getArtistEvents(artistName),
      ]);

      _videos = results[0] as List<VideoEntity>;
      _events = results[1] as List<EventEntity>;

      _state = ViewState.success;
    } catch (e) {
      _state = ViewState.error;
      _errorMessage =
          'Não foi possível carregar dados para $artistName. Erro: $e';
    }

    notifyListeners();
  }
}
