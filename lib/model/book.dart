class BookModel {
  Content? content;

  BookModel({this.content});

  BookModel.fromJson(Map<String, dynamic> json) {
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
  bool? isFree;
  bool? isFavorite;
  bool? isOwned;
  int? bId;
  String? bName;
  String? bDescription;
  String? bGenre;
  double? bPrice;
  int? aId;
  String? bCreatedOn;
  String? coverImageUrl;

  Book(
      {this.isFree,
      this.isFavorite,
      this.isOwned,
      this.bId,
      this.bName,
      this.bDescription,
      this.bGenre,
      this.bPrice,
      this.aId,
      this.bCreatedOn,
      this.coverImageUrl});

  Book.fromJson(Map<String, dynamic> json) {
    isFree = json['is_free'] ?? false;
    isOwned = json['is_owned'] ?? false;
    bId = json['b_id'] ?? 0;
    bName = json['b_name'] ?? '';
    bDescription = json['b_description'] ?? '';
    bGenre = json['b_genre'] ?? '';
    bPrice = json['b_price'] ??0.0;
    aId = json['a_id'] ?? 0;
    bCreatedOn = json['b_created_on'] ?? '';
    coverImageUrl = json['cover_image_url'] ?? '';
    isFavorite = json['is_favorite'] ?? false;
  }
}
