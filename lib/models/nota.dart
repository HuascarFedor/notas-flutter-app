class Nota {
  final int? id;
  final String content;

  Nota({this.id, this.content = ''});

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'content': content,
    };
  }
}
