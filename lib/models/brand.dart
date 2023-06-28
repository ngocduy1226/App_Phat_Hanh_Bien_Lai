class Brand {
  final String? id;
<<<<<<< HEAD
  final double denominations;
  final String content;

  Brand({
    this.id,
    required this.denominations,
=======
  late final String content;
  late final double denominations;

  Brand({
    this.id,
>>>>>>> fe7460e13db9f271a36ee2d3a0f71b064820c293
    required this.content,
    required this.denominations,
  });

  Brand copyWith({
    String? id,
<<<<<<< HEAD
    double? denominations,
=======
>>>>>>> fe7460e13db9f271a36ee2d3a0f71b064820c293
    String? content,
    double? denominations,
  }) {
    return Brand(
      id: id ?? this.id,
<<<<<<< HEAD
      denominations: denominations ?? this.denominations,
=======
>>>>>>> fe7460e13db9f271a36ee2d3a0f71b064820c293
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
