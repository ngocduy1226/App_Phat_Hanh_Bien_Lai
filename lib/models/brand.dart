class Brand {
  final String? id;
  final double denominations;
  final String content;

  Brand({
    this.id,
    required this.denominations,
    required this.content,
  });

  Brand copyWith({
    String? id,
    double? denominations,
    String? content,
  }) {
    return Brand(
      id: id ?? this.id,
      denominations: denominations ?? this.denominations,
      content: content ?? this.content,
    );
  }
}
