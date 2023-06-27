class Brand {
  final String? id;
  late final String content;
  late final double denominations;

  Brand({
    this.id,
    required this.content,
    required this.denominations,
  });

  Brand copyWith({
    String? id,
    String? content,
    double? denominations,
  }) {
    return Brand(
      id: id ?? this.id,
      content: content ?? this.content,
      denominations: denominations ?? this.denominations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'denominations': denominations,
    };
  }

  @override
  String toString() {
    return 'Brand{id:$id, content:$content, denominations:$denominations}';
  }
}
