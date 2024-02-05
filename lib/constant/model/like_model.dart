class LikeModel {
  String likeID;
  String postID;
  String userID;
  bool begendim;

  LikeModel({
    required this.likeID,
    required this.postID,
    required this.userID,
    this.begendim = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "likeID": likeID,
      "postID": postID,
      "userID": userID,
      "begendim": begendim,
    };
  }

  LikeModel.fromMap(Map<String, dynamic> map)
      : likeID = map['likeID'],
        postID = map['postID'],
        userID = map['userID'],
        begendim = map['begendim'];
}
