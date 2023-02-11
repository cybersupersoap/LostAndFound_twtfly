
class Comment{
  final String date;
  final String content;
  final int postID;
  Comment.fromJson(Map<String ,dynamic> json):
      this.date=json['antime'],
      this.content=json['content'],
      this.postID=json['postid'];
}
