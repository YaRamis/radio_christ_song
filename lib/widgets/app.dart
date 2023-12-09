import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:radio_christ_song/redux/app_middlewares.dart';
import 'package:radio_christ_song/redux/app_reducers.dart';
import 'package:radio_player/radio_player.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../domain/api_clients/request_parameters.dart';
import '../redux/app_state.dart';
import 'main_menu_screens/main_menu_main_screen.dart';
import 'main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';
import 'main_menu_screens/main_menu_radio_screen/main_menu_radio_timer_screen.dart';

Timer timerStop = Timer(const Duration(), () {});
Timer countdownTimer = Timer(const Duration(), () {});
final ValueNotifier<bool> isTimerActive = ValueNotifier<bool>(false);
MainMenuRadioTimerScreenWidget mainMenuRadioTimerScreenWidget =
    const MainMenuRadioTimerScreenWidget();

// bool isTrackChanged = false;

final radioPlayer = RadioPlayer();
bool isPlaying = false;
List<String>? metadata;

final Store<AppState> store = Store(
  appReducer,
  initialState: AppState.initialState(),
  middleware: [thunkMiddleware],
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isSetCustomMetadata = false;

  @override
  void initState() {
    initRadioPlayer();
    super.initState();
  }

  void initRadioPlayer() async {
    radioPlayer.setChannel(
      title: 'Радио Христианская Песня',
      url: 'https://pu.xpradio.ru:4085/radio',
    );

    radioPlayer.metadataStream.listen((value) async {
      if (!isSetCustomMetadata) {
        metadata = value;
        await store.dispatch(fetchRadioTracksHistory(
            GetRadioTracksHistoryParameters(limit: 1, offset: 0),
            (int id, String? image) async {
          final paletteGenerator = await updatePaletteGenerator(
              image ?? 'assets/images/default_cover.png');
          radioScreenBackgroundColor.value = paletteGenerator
                  .darkVibrantColor?.color ??
              (paletteGenerator.darkMutedColor?.color ?? Colors.grey.shade600);
          currentTrackId.value = id;
          radioPlayer
              .setDefaultArtwork(image ?? 'assets/images/default_cover.png');
          isSetCustomMetadata = true;
          radioPlayer.setCustomMetadata([
            store.state.radioTracksHistory.tracks[0].author,
            store.state.radioTracksHistory.tracks[0].title,
            store.state.radioTracksHistory.tracks[0].imageMediumUrl ??
                'assets/images/default_cover.png',
          ]);
        }));
      } else {
        isSetCustomMetadata = false;
      }
    });

    await store.dispatch(fetchRadioTracksHistory(
        GetRadioTracksHistoryParameters(limit: 1, offset: 0),
        (int id, String? image) async {
      final paletteGenerator = await updatePaletteGenerator(
          image ?? 'assets/images/default_cover.png');
      radioScreenBackgroundColor.value =
          paletteGenerator.darkVibrantColor?.color ??
              (paletteGenerator.darkMutedColor?.color ?? Colors.grey.shade600);
      currentTrackId.value = id;
      radioPlayer.setDefaultArtwork(image ?? 'assets/images/default_cover.png');
    }));

    radioPlayer.setCustomMetadata([
      store.state.radioTracksHistory.tracks[0].author,
      store.state.radioTracksHistory.tracks[0].title,
      store.state.radioTracksHistory.tracks[0].imageMediumUrl ??
          'assets/images/default_cover.png',
    ]);

    radioPlayer.stateStream.listen((value) {
      isPlaying = value;
      if (isPlaying) {
        timerStop.cancel();
      } else {
        timerStop = Timer(const Duration(seconds: 5), () {
          radioPlayer.setCustomMetadata([
            metadata?[1] ?? store.state.radioTracksHistory.tracks[0].title,
            metadata?[0] ?? store.state.radioTracksHistory.tracks[0].author,
            store.state.radioTracksHistory.tracks[0].imageMediumUrl ??
                'assets/images/default_cover.png',
          ]);
          radioPlayer.stop();
        });
      }
    });

    radioPlayer.stop();
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Радио Христианская Песня',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Exo2',
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
          scaffoldBackgroundColor: Colors.grey.shade600,
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade600,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          useMaterial3: true,
          fontFamily: 'Exo2',
        ),
        home: const MainMenuMainScreenWidget(),
      ),
    );
  }
}
