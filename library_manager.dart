import 'dart:convert';
import 'dart:io';
import 'book.dart';
import 'author.dart';
import 'member.dart';
import 'utils.dart';

class LibraryManager {
  List<Book> _books = [];
  List<Author> _authors = [];
  List<Member> _members = [];



  

   
  bool authorExistsById(String authorId) {
    return _authors.any((author) => author.id == authorId);
  }

   

  
  void searchMembers(String query) {
    final results = _members.where((member) =>
      member.name.contains(query) || member.id.contains(query)).toList();
    
    if (results.isEmpty) {
      print('No members found matching query "$query".');
    } else {
      results.forEach((member) {
        print('ID: ${member.id}, Name: ${member.name}');
        });
    }
  }

  
  void searchMember(String query) {
    final results = _members.where((member) =>
      member.name.contains(query) || member.id.contains(query)).toList();
    
    if (results.isEmpty) {
      print('No members found matching query "$query".');
    } else {
      results.forEach((member) {
        print('ID: ${member.id}, Name: ${member.name}');
      });
    }
  }
  


  Future<void> loadData() async {
    try {
      final booksFile = File('books.json');
      final authorsFile = File('authors.json');
      final membersFile = File('members.json');

      if (await booksFile.exists()) {
        final booksData = jsonDecode(await booksFile.readAsString()) as List<dynamic>;
        _books = booksData.map((json) => Book.fromJson(json as Map<String, dynamic>)).toList();
        print('Books loaded: ${_books.length}');
      }

      if (await authorsFile.exists()) {
        final authorsData = jsonDecode(await authorsFile.readAsString()) as List<dynamic>;
        _authors = authorsData.map((json) => Author.fromJson(json as Map<String, dynamic>)).toList();
        print('Authors loaded: ${_authors.length}');
      }

      if (await membersFile.exists()) {
        final membersData = jsonDecode(await membersFile.readAsString()) as List<dynamic>;
        _members = membersData.map((json) => Member.fromJson(json as Map<String, dynamic>)).toList();
        print('Members loaded: ${_members.length}');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> saveData() async {
    try {
      final booksFile = File('books.json');
      final authorsFile = File('authors.json');
      final membersFile = File('members.json');

      await booksFile.writeAsString(jsonEncode(_books.map((book) => book.toJson()).toList()));
      await authorsFile.writeAsString(jsonEncode(_authors.map((author) => author.toJson()).toList()));
      await membersFile.writeAsString(jsonEncode(_members.map((member) => member.toJson()).toList()));
      print('Data saved successfully.');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  String generateUniqueBookId() {
    return 'book_${DateTime.now().millisecondsSinceEpoch}';
  }

  String generateUniqueAuthorId() {
    return 'author_${DateTime.now().millisecondsSinceEpoch}';
  }

  String generateUniqueMemberId() {
    return 'member_${DateTime.now().millisecondsSinceEpoch}';
  }

  bool bookExists(String isbn) {
    return _books.any((book) => book.isbn == isbn);
  }

  bool authorExists(String name, DateTime dob) {
    return _authors.any((author) => author.name == name && author.dateOfBirth == dob);
  }

  bool memberExists(String id) {
    return _members.any((member) => member.id == id);
  }

  void addBook(Book book) {
    if (bookExists(book.isbn)) {
      print('Book with ISBN ${book.isbn} already exists.');
    } else {
      _books.add(book);
      print('Book added successfully with ID ${book.id}.');
    }
  }

 void addAuthor(Author author) {
  
  if (_authors.any((a) => a.id == author.id)) {
    print('Author with ID ${author.id} already exists.');
    return;
  }


 
  print('Author added successfully with ID ${author.id}.');
}

  void addMember(Member member) {
    if (memberExists(member.id)) {
      print('Member with ID ${member.id} already exists.');
    } else {
      _members.add(member);
      print('Member added successfully with ID ${member.id}.');
    }
  }

  void viewBooks() {
    if (_books.isEmpty) {
      print('No books available.');
    } else {
      _books.forEach((book) {
        print('ID: ${book.id}, Title: ${book.title}, Author: ${book.author}, Publication Year: ${book.publicationYear}, Genre: ${book.genre}, ISBN: ${book.isbn}');
      });
    }
  }
void viewAuthors() {
  if (_authors.isEmpty) {
    print('No authors available.');
  } else {
    _authors.forEach((author) {
      print('ID: ${author.id}, Name: ${author.name}, Date of Birth: ${author.dateOfBirth.toLocal()}');
    });
  }
}
  void viewMembers() {
    if (_members.isEmpty) {
      print('No members available.');
    } else {
      _members.forEach((member) {
        print('ID: ${member.id}, Name: ${member.name}');
      });
    }
  }

  void updateBook(String isbn) {
  try {
    final book = _books.firstWhere((b) => b.isbn == isbn);
    print('Updating book with ISBN $isbn.');

    print('Select field to update:');
    print('1. Title');
    print('2. Author');
    print('3. Publication Year');
    print('4. Genre');
    print('Enter your choice: ');

    int choice = getValidIntInput('');

    switch (choice) {
      case 1:
        book.title = getValidInput('Enter new title: ');
        print('Title updated successfully.');
        break;
      case 2:
        book.author = getValidInput('Enter new author: ');
        print('Author updated successfully.');
        break;
      case 3:
        book.publicationYear = getValidIntInput('Enter new publication year: ');
        print('Publication year updated successfully.');
        break;
      case 4:
        book.genre = getValidInput('Enter new genre: ');
        print('Genre updated successfully.');
        break;
      default:
        print('Invalid choice, no field updated.');
        break;
    }
  } catch (e) {
    print('Book with ISBN $isbn not found.');
  }
}


  void updateAuthor(String authorId) {
  try {
    final author = _authors.firstWhere((a) => a.id == authorId);
    print('Updating author with ID $authorId.');

    
    author.name = getValidInput(
      'Enter new name: ',
      validator: (input) => isValidName(input)
          ? ''
          : 'Invalid name. Please enter alphabetic characters only.',
    );

    
    DateTime dob;
    while (true) {
      try {
        dob = DateTime.parse(getValidInput('Enter new date of birth (YYYY-MM-DD): '));
        break; 
      } catch (e) {
        print('Invalid date format. Please enter the date in YYYY-MM-DD format.');
      }
    }
    author.dateOfBirth = dob;

    
    String booksInput = getValidInput(
        'Enter a comma-separated list of books written by the author (e.g., Book1, Book2): ');
    List<String> booksWritten = booksInput.split(',').map((book) => book.trim()).toList();
    author.booksWritten = booksWritten;

    print('Author updated successfully.');
  } catch (e) {
    print('Author with ID $authorId not found.');
  }
}

  void updateMember(String memberId) {
    try {
      final member = _members.firstWhere((m) => m.id == memberId);
      print('Updating member with ID $memberId.');
      member.name = getValidInput('Enter new name: ');
      print('Member updated successfully.');
    } catch (e) {
      print('Member with ID $memberId not found.');
    }
  }

  void deleteBook(String isbn) {
    try {
      final book = _books.firstWhere((b) => b.isbn == isbn);
      _books.remove(book);
      print('Book with ISBN $isbn deleted successfully.');
    } catch (e) {
      print('Book with ISBN $isbn not found.');
    }
  }

  void deleteAuthor(String authorId) {
    try {
      final author = _authors.firstWhere((a) => a.id == authorId);
      _authors.remove(author);
      print('Author with ID $authorId deleted successfully.');
    } catch (e) {
      print('Author with ID $authorId not found.');
    }
  }

  void deleteMember(String memberId) {
    try {
      final member = _members.firstWhere((m) => m.id == memberId);
      _members.remove(member);
      print('Member with ID $memberId deleted successfully.');
    } catch (e) {
      print('Member with ID $memberId not found.');
    }
  }

  void searchBooks(String query) {
    final results = _books.where((book) =>
      book.title.contains(query) ||
      book.author.contains(query) ||
      book.genre.contains(query)).toList();

    if (results.isEmpty) {
      print('No books found matching query "$query".');
    } else {
      results.forEach((book) {
        print('ID: ${book.id}, Title: ${book.title}, Author: ${book.author}, Publication Year: ${book.publicationYear}, Genre: ${book.genre}, ISBN: ${book.isbn}');
      });
    }
  }

  void lendBook(String bookId, String memberId, DateTime dueDate) {
    print('Book with ID $bookId lent to member with ID $memberId, due on $dueDate.');
  }

  void returnBook(String bookId, String memberId) {
    print('Book with ID $bookId returned by member with ID $memberId.');
  }
}
