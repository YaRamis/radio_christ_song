class GetRadioTracksHistoryParameters {
  final int limit;
  final int offset;

  GetRadioTracksHistoryParameters({
    required this.limit,
    required this.offset,
  });
}

class GetRadioAllNewsParameters {
  final int limit;
  final int offset;

  GetRadioAllNewsParameters({
    required this.limit,
    required this.offset,
  });
}

class GetRadioDjsParameters {
  GetRadioDjsParameters();
}

class GetRadioChartTracksParameters {
  final bool isBest;

  GetRadioChartTracksParameters({
    required this.isBest,
  });
}

class GetRadioOrderTracksParameters {
  final int limit;
  final int offset;
  final String searchQuery;
  final bool withTagsOnly;
  final bool requestable;
  final int order;
  final String? urlString;

  GetRadioOrderTracksParameters({
    required this.limit,
    required this.offset,
    this.searchQuery = '',
    this.withTagsOnly = true,
    this.requestable = true,
    this.order = 1,
    this.urlString,
  });
}

class PostTrackRatingParameters {
  final int id;
  final bool isLike;

  PostTrackRatingParameters({
    required this.id,
    required this.isLike,
  });
}

class PostTrackRequestParameters {
  final int id;
  final String message;
  final String person;

  PostTrackRequestParameters({
    required this.id,
    required this.message,
    required this.person,
  });
}

class PostFeedbackParameters {
  final String email;
  final String message;
  final String subject;

  PostFeedbackParameters({
    required this.email,
    required this.message,
    required this.subject,
  });
}
