class Brand {
  final String? id;
  final String title;
  final String content;

  Brand({
    this.id,
    required this.title,
    required this.content,
  });

  Brand copyWith({
    String? id,
    String? title,
    String? content,
  }) {
    return Brand(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
