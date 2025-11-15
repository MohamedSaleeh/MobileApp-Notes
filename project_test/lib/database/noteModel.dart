class Notemodel {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int userId;
  Notemodel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'created_at': createdAt.toString(),
    };
  }

  factory Notemodel.fromMap(Map<String, dynamic> map) {
    return Notemodel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      userId: map['user_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
