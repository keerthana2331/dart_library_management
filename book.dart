class Book {
  String id;
  String title;
  String author;
  int publicationYear;
  String genre;
  String isbn;

  Book({required this.id, required this.title, required this.author, required this.publicationYear, required this.genre, required this.isbn});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      publicationYear: json['publicationYear'],
      genre: json['genre'],
      isbn: json['isbn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publicationYear': publicationYear,
      'genre': genre,
      'isbn': isbn,
    };
  }
}
