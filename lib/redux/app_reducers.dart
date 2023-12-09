import 'package:radio_christ_song/redux/app_actions.dart';
import '../domain/entities/radio_chart/radio_chart.dart';
import '../domain/entities/radio_djs/radio_djs.dart';
import '../domain/entities/radio_order_tracks/radio_order_tracks.dart';
import '../domain/entities/radio_tracks_history/radio_tracks_history.dart';
import 'app_state.dart';

AppState appReducer(AppState previousState, action) {
  return AppState(
    radioChartBestTracks: setRadioChartBestTracks(previousState, action),
    radioChartWorstTracks: setRadioChartWorstTracks(previousState, action),
    radioDjs: setRadioDjsReducer(previousState, action),
    radioOrderTracks: setRadioOrderTracksReducer(previousState, action),
    radioTracksHistory: setRadioTracksHistoryReducer(previousState, action),
  );
}

RadioTracksHistory setRadioTracksHistoryReducer(
    AppState previousState, action) {
  if (action is SetRadioTracksHistoryAction) {
    return action.radioTracksHistory;
  } else {
    return previousState.radioTracksHistory;
  }
}

List<RadioChartTrack> setRadioChartBestTracks(AppState previousState, action) {
  if (action is SetRadioChartBestTracksAction) {
    return action.radioChartBestTracks;
  } else {
    return previousState.radioChartBestTracks;
  }
}

List<RadioChartTrack> setRadioChartWorstTracks(AppState previousState, action) {
  if (action is SetRadioChartWorstTracksAction) {
    return action.radioChartWorstTracks;
  } else {
    return previousState.radioChartWorstTracks;
  }
}

RadioOrderTracks setRadioOrderTracksReducer(AppState previousState, action) {
  if (action is SetRadioOrderTracksAction) {
    return action.radioOrderTracks;
  } else {
    return previousState.radioOrderTracks;
  }
}

List<RadioDj> setRadioDjsReducer(AppState previousState, action) {
  if (action is SetRadioDjsAction) {
    return action.radioDjs;
  } else {
    return previousState.radioDjs;
  }
}
