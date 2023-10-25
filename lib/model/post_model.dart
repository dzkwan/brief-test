class Post {
  final int id;
  final int userId;
  final String name;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.name,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        title: json['title'],
        body: json['body'],
      );
}
