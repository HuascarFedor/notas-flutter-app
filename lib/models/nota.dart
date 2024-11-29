class Nota {
  final int? id;
  final String content;
  bool finished;
  final String createdAt;

  Nota({
    this.id,
    this.content = '',
    this.finished = false,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      content: map['content'] ?? '',
      finished: map['finished'] == 1 ? true : false,
      createdAt: map['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'content': content,
      'finished': finished ? 1 : 0,
      'created_at': createdAt,
    };
  }
}
