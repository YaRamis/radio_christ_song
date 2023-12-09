import 'package:radio_christ_song/domain/entities/radio_chart/radio_chart.dart';
import 'package:radio_christ_song/domain/entities/radio_order_tracks/radio_order_tracks.dart';

import '../domain/entities/radio_djs/radio_djs.dart';
import '../domain/entities/radio_news/radio_all_news.dart';
import '../domain/entities/radio_tracks_history/radio_tracks_history.dart';

abstract class AppAction {}

class SetRadioTracksHistoryAction extends AppAction {
  final RadioTracksHistory _radioTracksHistory;

  SetRadioTracksHistoryAction({required RadioTracksHistory radioTracksHistory})
      : _radioTracksHistory = radioTracksHistory;

  RadioTracksHistory get radioTracksHistory => _radioTracksHistory;
}

class SetRadioAllNewsAction extends AppAction {
  final RadioAllNews _radioAllNews;

  SetRadioAllNewsAction({required RadioAllNews radioAllNews})
      : _radioAllNews = radioAllNews;

  RadioAllNews get radioAllNews => _radioAllNews;
}

class SetRadioOrderTracksAction extends AppAction {
  final RadioOrderTracks _radioOrderTracks;

  SetRadioOrderTracksAction({required RadioOrderTracks radioOrderTracks})
      : _radioOrderTracks = radioOrderTracks;

  RadioOrderTracks get radioOrderTracks => _radioOrderTracks;
}

class SetRadioDjsAction extends AppAction {
  final List<RadioDj> _radioDjs;

  SetRadioDjsAction({required List<RadioDj> radioDjs}) : _radioDjs = radioDjs;

  List<RadioDj> get radioDjs => _radioDjs;
}

class SetRadioChartBestTracksAction extends AppAction {
  final List<RadioChartTrack> _radioChartBestTracks;

  SetRadioChartBestTracksAction(
      {required List<RadioChartTrack> radioChartBestTracks})
      : _radioChartBestTracks = radioChartBestTracks;

  List<RadioChartTrack> get radioChartBestTracks => _radioChartBestTracks;
}

class SetRadioChartWorstTracksAction extends AppAction {
  final List<RadioChartTrack> _radioChartWorstTracks;

  SetRadioChartWorstTracksAction(
      {required List<RadioChartTrack> radioChartWorstTracks})
      : _radioChartWorstTracks = radioChartWorstTracks;

  List<RadioChartTrack> get radioChartWorstTracks => _radioChartWorstTracks;
}

class RateTrackAction extends AppAction {}

class RequestTrackAction extends AppAction {}

class FeedbackAction extends AppAction {}

// class FetchAllRadioDataAction extends AppAction {
//   final List<RadioChartTrack> _radioChartTracks;
//   final List<RadioDj> _radioDj;
//   final RadioOrderTracks _radioOrderTracks;
//   final RadioTracksHistory _radioTracksHistory;
//
//   FetchAllRadioDataAction(
//       {required List<RadioChartTrack> radioChartWorstTracks,
//       required List<RadioChartTrack> radioChartBestTracks,
//       required List<RadioDj> radioDj,
//       required RadioOrderTracks radioOrderTracks,
//       required RadioTracksHistory radioTracksHistory})
//       : _radioChartTracks = radioChartWorstTracks,
//         _radioDj = radioDj,
//         _radioOrderTracks = radioOrderTracks,
//         _radioTracksHistory = radioTracksHistory;
// }
