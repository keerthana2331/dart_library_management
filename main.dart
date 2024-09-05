import 'dart:io';
import 'library_manager.dart';
import 'utils.dart';
import 'book.dart';
import 'author.dart';
import 'member.dart';


int getValidPublicationYear(String prompt) {
  while (true) {
    String input = getValidInput(prompt);

    
    if (input.length == 4 && int.tryParse(input) != null) {
      int year = int.parse(input);
      if (year >= 1000 && year <= 9999) {
        return year; 
      } else {
        print('Year must be between 1000 and 9999. Please enter again.');
      }
    } else {
      print('Invalid year. Please enter a 4-digit number.');
    }
  }
}


void main() async {
  final libraryManager = LibraryManager();




  
  await libraryManager.loadData(); 

  while (true) {
    print('\nLibrary Management System');
    print('1. Add Book');
    print('2. View Books');
    print('3. Update Book');
    print('4. Delete Book');
    print('5. Search Books');
    print('6. Lend Book');
    print('7. Return Book');
    print('8. Add Author');
    print('9. View Authors');
    print('10. Update Author');
    print('11. Delete Author');
    print('12. Add Member');
    print('13. View Members');
    print('14. Update Member');
    print('15. Delete Member');
    print('16. Search Member');
    print('17. Save ');
    print('18 exit ') ;

    String choice = getValidInput('Enter your choice: ');

    switch (choice) {
      case '1': 
           String title = getValidInput('Enter book title: ');
        String author = getValidInput('Enter author name: ',
            validator: (input) => isValidName(input)
                ? ''
                : 'Invalid author name. Please enter alphabetic characters only.');

        int year = getValidPublicationYear('Enter publication year (YYYY): '); // Correct usage of the function

        String genre = getValidInput('Enter genre: ');
        String isbn;
        do {
          isbn = getValidInput('Enter ISBN: ');
          if (!isValidIsbn(isbn)) {
            print('Invalid ISBN. Please enter a 13-digit number.');
          }
        } while (!isValidIsbn(isbn));

        if (!libraryManager.bookExists(isbn)) {
          final book = Book(
              id: libraryManager.generateUniqueBookId(),
              title: title,
              author: author,
              publicationYear: year,
              genre: genre,
              isbn: isbn);
          libraryManager.addBook(book);
        } else {
          print('Book with ISBN $isbn already exists.');
        }
        break;

      case '2': 
        libraryManager.viewBooks();
        break;

      case '3': 

      

     String newAuthor;
  do {
    newAuthor = getValidInput('Enter new author: ');
    if (!isValidName(newAuthor)) {
      print('Invalid author name. Please enter only alphabetic characters.');
    }
  } while (!isValidName(newAuthor));
  
        String isbn = getValidInput('Enter the ISBN of the book to update: ');
        libraryManager.updateBook(isbn);
        break;


        

      case '4': 
        String isbn = getValidInput('Enter the ISBN of the book to delete: ');
        libraryManager.deleteBook(isbn);
        break;

      case '5': 
        String query =
            getValidInput('Enter search query (title/author/genre): ');
        libraryManager.searchBooks(query);
        break;

      case '6':
        String bookId = getValidInput('Enter book ID: ');
        String memberId = getValidInput('Enter member ID: ');
        DateTime dueDate =
            DateTime.parse(getValidInput('Enter due date (YYYY-MM-DD): '));
        libraryManager.lendBook(bookId, memberId, dueDate);
        break;

      case '7': 
        String bookId = getValidInput('Enter book ID: ');
        String memberId = getValidInput('Enter member ID: ');
        libraryManager.returnBook(bookId, memberId);
        break;

      
        
case '8': 
  String authorName;
  do {
    authorName = getValidInput('Enter author name: ',
        validator: (input) => isValidName(input)
            ? ''
            : 'Invalid author name. Please enter alphabetic characters only.');
  } while (authorName.isEmpty);

  DateTime dob;
  while (true) {
    try {
      dob = DateTime.parse(getValidInput('Enter date of birth (YYYY-MM-DD): '));
      break; 
    } catch (e) {
      print('Invalid date format. Please enter the date in YYYY-MM-DD format.');
    }
  }

  String authorId;
  bool isUniqueId;
  do {
    authorId = getValidInput('Enter author ID: ');
    isUniqueId = !libraryManager.authorExistsById(authorId);

    if (!isUniqueId) {
      print('Author with ID $authorId already exists. Please enter a different ID.');
    }
  } while (!isUniqueId);

  
  String booksInput = getValidInput(
      'Enter a comma-separated list of books written by the author (e.g., Book1, Book2, Book3): ');

  
  List<String> booksWritten = booksInput.split(',').map((book) => book.trim()).toList();

  final author = Author(
    id: authorId,
    name: authorName,
    dateOfBirth: dob,
    booksWritten: booksWritten, 
  );

  libraryManager.addAuthor(author);
  print('Author added successfully with ID $authorId.');
  if (booksWritten.isNotEmpty) {
    print('Books written by the author:');
    booksWritten.forEach((book) => print('- $book'));
  } else {
    print('No books were listed as written by the author.');
  }
  break;


      case '9': 
        libraryManager.viewAuthors();
        break;

        

      case '10': 
        String authorId =
            getValidInput('Enter the ID of the author to update: ');
        libraryManager.updateAuthor(authorId);
        break;

      case '11': 
        String authorId =
            getValidInput('Enter the ID of the author to delete: ');
        libraryManager.deleteAuthor(authorId);
        break;

      case '12': 
  String memberId;
  do {
    memberId = getValidInput('Enter member ID: ');
    if (libraryManager.memberExists(memberId)) {
      print(
          'Member with ID $memberId already exists. Please enter a different ID.');
    }
  } while (libraryManager.memberExists(memberId));

  String memberName;
  do {
    memberName = getValidInput('Enter member name: ',
        validator: (input) => isValidName(input)
            ? ''
            : 'Invalid member name. Please enter alphabetic characters only.');
  } while (!isValidName(memberName));

 
  String borrowedBooksInput = getValidInput(
      'Enter a comma-separated list of books borrowed by the member (e.g., Book1, Book2, Book3), or leave empty if none: ');

  
  List<String> borrowedBooks = borrowedBooksInput.isNotEmpty
      ? borrowedBooksInput.split(',').map((book) => book.trim()).toList()
      : [];

  final member = Member(
    id: memberId,
    name: memberName,
    borrowedBooks: borrowedBooks, 
  );

  libraryManager.addMember(member);
  print('Member added successfully with ID $memberId.');
  if (borrowedBooks.isNotEmpty) {
    print('Books borrowed by the member:');
    borrowedBooks.forEach((book) => print('- $book'));
  } else {
    print('No books were listed as borrowed by the member.');
  }
  break;


      case '13': 
        libraryManager.viewMembers();
        break;

      case '14': 
        String memberId =
            getValidInput('Enter the ID of the member to update: ');
        libraryManager.updateMember(memberId);
        break;

      case '15': 
        String memberId =
            getValidInput('Enter the ID of the member to delete: ');
        libraryManager.deleteMember(memberId);
        break;

         case '16': 
        String query =
            getValidInput('Enter search query (name/id): ');
        libraryManager.searchMember(query);
        break;

     case '17':
    await libraryManager.saveData();
    print('Data saved successfully.');
    break;

  case '18': 
    print('Exiting without saving...');
    return;

  default:
    print('Invalid choice, please try again.');
    break;
    }
  }
}
