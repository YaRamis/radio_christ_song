import 'package:radio_christ_song/domain/entities/radio_chart/radio_chart.dart';
import 'package:radio_christ_song/domain/entities/radio_djs/radio_djs.dart';
import 'package:radio_christ_song/domain/entities/radio_order_tracks/radio_order_tracks.dart';
import 'package:radio_christ_song/domain/entities/radio_tracks_history/radio_tracks_history.dart';

import '../domain/entities/radio_tracks_history/track_history.dart';

class AppState {
  final List<RadioChartTrack> _radioChartBestTracks;
  final List<RadioChartTrack> _radioChartWorstTracks;
  final List<RadioDj> _radioDjs;
  final RadioOrderTracks _radioOrderTracks;
  final RadioTracksHistory _radioTracksHistory;

  AppState({
    required List<RadioChartTrack> radioChartBestTracks,
    required List<RadioChartTrack> radioChartWorstTracks,
    required List<RadioDj> radioDjs,
    required RadioOrderTracks radioOrderTracks,
    required RadioTracksHistory radioTracksHistory,
  })  : _radioChartBestTracks = radioChartBestTracks,
        _radioChartWorstTracks = radioChartWorstTracks,
        _radioDjs = radioDjs,
        _radioOrderTracks = radioOrderTracks,
        _radioTracksHistory = radioTracksHistory;

  List<RadioChartTrack> get radioChartBestTracks => _radioChartBestTracks;
  List<RadioChartTrack> get radioChartWorstTracks => _radioChartWorstTracks;
  List<RadioDj> get radioDjs => _radioDjs;
  RadioOrderTracks get radioOrderTracks => _radioOrderTracks;
  RadioTracksHistory get radioTracksHistory => _radioTracksHistory;

  AppState.initialState()
      : _radioChartBestTracks = [
          RadioChartTrack(
            id: -1,
            filename: '',
            meta: '',
            rating: 0,
            publicPath: '',
            path: '',
            author: '',
            title: '',
            album: '',
            thumbsUp: 0,
            thumbsDown: 0,
            tagImage: null,
            imageMedium: null,
            imageLarge: null,
          ),
        ],
        _radioChartWorstTracks = [
          RadioChartTrack(
            id: -1,
            filename: '',
            meta: '',
            rating: 0,
            publicPath: '',
            path: '',
            author: '',
            title: '',
            album: '',
            thumbsUp: 0,
            thumbsDown: 0,
            tagImage: null,
            imageMedium: null,
            imageLarge: null,
          ),
        ],
        _radioDjs = [],
        _radioOrderTracks =
            RadioOrderTracks(count: 0, next: '', previous: '', tracks: []),
        _radioTracksHistory = RadioTracksHistory(tracks: [
          TrackHistory(
              id: -1,
              allMusicId: -1,
              imageUrl: null,
              imageMediumUrl: null,
              imageLargeUrl: null,
              djName: '',
              metadata: '',
              author: '',
              title: '',
              playlistTitle: '',
              album: '')
        ], count: -1);
}
