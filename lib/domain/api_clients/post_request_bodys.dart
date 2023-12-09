abstract class PostRequestBody {}

class PostTrackRequestBody extends PostRequestBody {
  final String ipTimeout;
  final String message;
  final int musicId;
  final String person;
  final int serverId;
  final String trackTimeout;

  PostTrackRequestBody({
    required this.ipTimeout,
    required this.message,
    required this.musicId,
    required this.person,
    required this.serverId,
    required this.trackTimeout,
  });

  Map<String, dynamic> postTrackRequestBodyToJson() => <String, dynamic>{
        'ip_timeout': ipTimeout,
        'message': message,
        'music_id': musicId,
        'person': person,
        'server_id': serverId,
        'track_timeout': trackTimeout,
      };
}

class PostFeedbackBody extends PostRequestBody {
  final String email;
  final String message;
  final String subject;

  PostFeedbackBody({
    required this.email,
    required this.message,
    required this.subject,
  });

  Map<String, dynamic> postFeedbackBodyToJson() => <String, dynamic>{
        'email': email,
        'message': message,
        'subject': subject,
      };
}
