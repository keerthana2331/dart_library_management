class Author {
  String id;
  String name;
  DateTime dateOfBirth;
  List<String> booksWritten;

  Author({required this.id, required this.name, required this.dateOfBirth,this.booksWritten= const []});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
       booksWritten: List<String>.from(json['booksWritten'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'booksWritten': booksWritten,
    };

    
}

  @override
  String toString() {
    return 'Author: $name, Date of Birth: $dateOfBirth, Books: ${booksWritten.join(', ')}';

  }
}

