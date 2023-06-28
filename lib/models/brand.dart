class Brand {
  final String? id;

  final double denominations;
  final String content;


  Brand({
    this.id,
   required this.content,
    required this.denominations,
  });

  Brand copyWith({
    String? id,
    double? denominations,
    String? content,
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
