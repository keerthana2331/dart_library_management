class Member {
  String id;
  String name;
    List<String> borrowedBooks;


 
  Member({required this.id, required this.name,this.borrowedBooks = const [],});

  
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      borrowedBooks: List<String>.from(json['borrowedbooks'] ?? []),
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'borrowedbooks': borrowedBooks,
    };
  }
}
