import 'package:radio_christ_song/domain/api_clients/radio_api_client.dart';
import 'package:radio_christ_song/domain/entities/radio_news/radio_all_news.dart';
import 'package:radio_christ_song/redux/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../domain/api_clients/request_parameters.dart';
import '../domain/entities/radio_order_tracks/radio_order_tracks.dart';
import 'app_state.dart';

ThunkAction<AppState> fetchRadioTracksHistory(
    GetRadioTracksHistoryParameters parameters,
    void Function(int, String?) onTrackChanged) {
  return (Store<AppState> store) {
    RadioApiClient.getRadioTracksHistory(parameters).then((value) async {
      int idFromStore = store.state.radioTracksHistory.tracks[0].allMusicId;
      int idFromReq = value.tracks[0].allMusicId;
      if (idFromReq != idFromStore) {
        await store
            .dispatch(SetRadioTracksHistoryAction(radioTracksHistory: value));
        onTrackChanged(idFromReq, value.tracks[0].imageMediumUrl);
      }
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchRadioDjs(GetRadioDjsParameters parameters) {
  return (Store<AppState> store) {
    RadioApiClient.getRadioDjs(parameters)
        .then((value) => store.dispatch(SetRadioDjsAction(radioDjs: value)))
        .catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchRadioChartBestTracks() {
  return (Store<AppState> store) {
    RadioApiClient.getRadioChartTracks(
            GetRadioChartTracksParameters(isBest: true))
        .then((value) => store.dispatch(
            SetRadioChartBestTracksAction(radioChartBestTracks: value)))
        .catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchRadioChartWorstTracks() {
  return (Store<AppState> store) {
    RadioApiClient.getRadioChartTracks(
            GetRadioChartTracksParameters(isBest: false))
        .then((value) => store.dispatch(
            SetRadioChartWorstTracksAction(radioChartWorstTracks: value)))
        .catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchRadioOrderTracks(
    GetRadioOrderTracksParameters parameters,
    void Function(RadioOrderTracks radioOrderTracks)
        onRadioOrderTracksReceived) {
  return (Store<AppState> store) {
    RadioApiClient.getRadioOrderTracks(parameters).then((value) {
      store.dispatch(SetRadioOrderTracksAction(radioOrderTracks: value));
      onRadioOrderTracksReceived(value);
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchRadioAllNews(GetRadioAllNewsParameters parameters,
    void Function(RadioAllNews radioAllNews) onRadioAllNewsReceived) {
  return (Store<AppState> store) {
    RadioApiClient.getRadioAllNews(parameters).then((value) {
      store.dispatch(SetRadioAllNewsAction(radioAllNews: value));
      onRadioAllNewsReceived(value);
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> sendTrackRating(PostTrackRatingParameters parameters,
    void Function() onTrue, void Function() onFalse) {
  return (Store<AppState> store) {
    RadioApiClient.postTrackRating(parameters).then((value) {
      if (value) {
        onTrue();
      } else {
        onFalse();
      }
      return store.dispatch(RateTrackAction());
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> sendFeedback(
    PostFeedbackParameters parameters, void Function(String?) onDone) {
  return (Store<AppState> store) {
    RadioApiClient.postFeedback(parameters).then((value) {
      onDone(value);
      return store.dispatch(FeedbackAction());
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> sendTrackRequest(PostTrackRequestParameters parameters,
    void Function() onSuccess, void Function() onFailed) {
  return (Store<AppState> store) {
    RadioApiClient.postTrackRequest(parameters).then((value) {
      if (value) {
        onSuccess();
      } else {
        onFailed();
      }
      return store.dispatch(RequestTrackAction());
    }).catchError((error) {
      print(error);
    });
  };
}

ThunkAction<AppState> fetchAllRadioData(
    GetRadioTracksHistoryParameters radioTracksHistoryParameters,
    GetRadioDjsParameters radioDjsParameters,
    GetRadioOrderTracksParameters radioOrderTracksParameters,
    GetRadioAllNewsParameters radioAllNewsParameters,
    void Function() callback) {
  return (Store<AppState> store) {
    store.dispatch(fetchRadioTracksHistory(radioTracksHistoryParameters,
        (int id, String? image) {
      callback();
    }));
    store.dispatch(fetchRadioDjs(radioDjsParameters));
    store.dispatch(fetchAllRadioChartTracks());
    store.dispatch(fetchRadioAllNews(radioAllNewsParameters, (a) {}));
    store.dispatch(fetchRadioOrderTracks(radioOrderTracksParameters, (a) {}));
  };
}

ThunkAction<AppState> fetchAllRadioChartTracks() {
  return (Store<AppState> store) {
    store.dispatch(fetchRadioChartBestTracks());
    store.dispatch(fetchRadioChartWorstTracks());
  };
}
