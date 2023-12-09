import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio_christ_song/domain/api_clients/post_request_bodys.dart';

import 'package:radio_christ_song/domain/api_clients/request_parameters.dart';
import 'package:radio_christ_song/domain/entities/radio_chart/radio_chart.dart';
import 'package:radio_christ_song/domain/entities/radio_djs/radio_djs.dart';
import 'package:radio_christ_song/domain/entities/radio_news/radio_all_news.dart';
import 'package:radio_christ_song/domain/entities/radio_order_tracks/radio_order_tracks.dart';
import 'package:radio_christ_song/domain/entities/radio_tracks_history/radio_tracks_history.dart';

abstract class RadioApiClient {
  static const _domain = 'https://pu.xpradio.ru:1030/api/v2/';
  static const _server = 1;

  static Future<RadioTracksHistory> getRadioTracksHistory(
      GetRadioTracksHistoryParameters parameters) async {
    final url = Uri.parse(
        '${_domain}history/?limit=${parameters.limit}&offset=${parameters.offset}&server=$_server');
    final json = (await _getJsonFromUrl(url)) as Map<String, dynamic>;

    return RadioTracksHistory.fromJson(json);
  }

  static Future<RadioAllNews> getRadioAllNews(
      GetRadioAllNewsParameters parameters) async {
    final url = Uri.parse(
        '${_domain}news/?limit=${parameters.limit}&offset=${parameters.offset}&server=$_server');
    final json = (await _getJsonFromUrl(url)) as Map<String, dynamic>;

    return RadioAllNews.fromJson(json);
  }

  static Future<List<RadioDj>> getRadioDjs(
      GetRadioDjsParameters parameters) async {
    final url = Uri.parse('${_domain}djs/?server=$_server');
    final jsonTmp = (await _getJsonFromUrl(url)) as List<dynamic>;
    final json = List.generate(
        jsonTmp.length, (index) => jsonTmp[index] as Map<String, dynamic>);

    return List.generate(json.length, (index) => RadioDj.fromJson(json[index]));
  }

  static Future<List<RadioChartTrack>> getRadioChartTracks(
      GetRadioChartTracksParameters parameters) async {
    final url = Uri.parse(
        '${_domain}track_stats/${parameters.isBest ? 'best' : 'worst'}/?server=$_server');
    final jsonTmp = (await _getJsonFromUrl(url)) as List<dynamic>;
    final json = List.generate(
        jsonTmp.length, (index) => jsonTmp[index] as Map<String, dynamic>);

    return List.generate(
        json.length, (index) => RadioChartTrack.fromJson(json[index]));
  }

  static Future<RadioOrderTracks> getRadioOrderTracks(
      GetRadioOrderTracksParameters parameters) async {
    final url = Uri.parse(parameters.urlString ??
        '${_domain}music/?limit=${parameters.limit}&offset=${parameters.offset}&search_q=${parameters.searchQuery}&server=$_server&with_tags_only=${parameters.withTagsOnly}&requestable=${parameters.requestable}&order=${parameters.order}');
    final json = (await _getJsonFromUrl(url)) as Map<String, dynamic>;

    return RadioOrderTracks.fromJson(json);
  }

  static Future<bool> postTrackRating(
      PostTrackRatingParameters parameters) async {
    final url = Uri.parse(
        '${_domain}music/${parameters.id}/${parameters.isLike ? 'like' : 'dislike'}/');
    final json = (await _postToApi(url)) as Map<String, dynamic>;

    return (json['result'] as String?) != null;
  }

  static Future<bool> postTrackRequest(
      PostTrackRequestParameters parameters) async {
    final url = Uri.parse('${_domain}track_requests/');
    final json = (await _postToApi(url,
        body: PostTrackRequestBody(
                ipTimeout: '100',
                message: parameters.message,
                musicId: parameters.id,
                person: parameters.person,
                serverId: _server,
                trackTimeout: '100')
            .postTrackRequestBodyToJson())) as Map<String, dynamic>;

    return (json['all_music'] as Map<String, dynamic>?) != null;
  }

  static Future<String?> postFeedback(PostFeedbackParameters parameters) async {
    final url = Uri.parse('${_domain}feedback/');
    final json = (await _postToApi(url,
        body: PostFeedbackBody(
                message: parameters.message,
                subject: parameters.subject,
                email: parameters.email)
            .postFeedbackBodyToJson())) as Map<String, dynamic>;

    return (json['status'] as String?);
  }

  static Future<dynamic> _getJsonFromUrl(Uri url) async {
    return jsonDecode(utf8.decode((await http.get(url)).bodyBytes));
  }

  static Future<dynamic> _postToApi(Uri url,
      {Map<String, dynamic>? body}) async {
    final jsonBody = json.encode(body);
    return jsonDecode(
        utf8.decode((await http.post(url, body: jsonBody, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    }))
            .bodyBytes));
  }
}
