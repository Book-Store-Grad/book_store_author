class AddBookModel {
  Content? content;

  AddBookModel({this.content});

  AddBookModel.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

}

class Content {
  Book? book;

  Content({this.book});

  Content.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }
}

class Book {
  int? bId;
  String? bName;
  String? bDescription;
  String? bGenre;
  String? bPrice;
  int? aId;

  Book(
      {this.bId,
        this.bName,
        this.bDescription,
        this.bGenre,
        this.bPrice,
        this.aId});

  Book.fromJson(Map<String, dynamic> json) {
    bId = json['b_id'];
    bName = json['b_name'];
    bDescription = json['b_description'];
    bGenre = json['b_genre'];
    bPrice = json['b_price'];
    aId = json['a_id'];
  }

}
