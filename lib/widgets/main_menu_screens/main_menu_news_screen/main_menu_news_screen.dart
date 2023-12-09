import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:radio_christ_song/domain/api_clients/request_parameters.dart';
import 'package:radio_christ_song/redux/app_middlewares.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';

import '../../../redux/app_state.dart';
import '../../../theme/app_colors.dart';
import 'main_menu_news_screen_card.dart';

class MainMenuNewsScreenWidget extends StatefulWidget {
  const MainMenuNewsScreenWidget({super.key});

  @override
  State<MainMenuNewsScreenWidget> createState() =>
      _MainMenuNewsScreenWidgetState();
}

class _MainMenuNewsScreenWidgetState extends State<MainMenuNewsScreenWidget> {
  static const _numberOfCardsPerRequest = 8;
  final PagingController<int, MainMenuNews> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    StoreProvider.of<AppState>(context).dispatch(fetchRadioAllNews(
        GetRadioAllNewsParameters(
            limit: _numberOfCardsPerRequest,
            offset: pageKey * _numberOfCardsPerRequest), (radioAllNews) {
      final tracks = radioAllNews.allNews
          .map((news) => MainMenuNews(
              id: news.id,
              title: news.title,
              imageUrl: news.imageUrl,
              text: news.text,
              datetime: DateTime.fromMillisecondsSinceEpoch(news.datetime),
              videoUrl: news.videoUrl))
          .toList();

      if (tracks.length < _numberOfCardsPerRequest) {
        _pagingController.appendLastPage(tracks);
      } else {
        _pagingController.appendPage(tracks, pageKey + 1);
      }
    }));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('Новости'),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          color: AppColors.blue,
          child: PagedListView<int, MainMenuNews>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (BuildContext context, item, int index) {
                return MainMenuNewsScreenCardWidget(news: item);
              },
              noItemsFoundIndicatorBuilder: (BuildContext context) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Новостей пока нет',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
