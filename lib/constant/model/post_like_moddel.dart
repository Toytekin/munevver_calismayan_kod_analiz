class PostLikeModel {
  final String postID;
  final int likeCount;
  final bool isLiked;

  PostLikeModel({
    required this.postID,
    required this.likeCount,
    required this.isLiked,
  });

  Map<String, dynamic> toMap() {
    return {
      "postID": postID,
      "likeCount": likeCount,
      "isLiked": isLiked,
    };
  }
}
