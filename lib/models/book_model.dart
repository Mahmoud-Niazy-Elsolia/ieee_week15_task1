class BookModel {
  final String imageUrl;
  final String title;
  final String author;
  final int id;

  BookModel({
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.id,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        title: json['title'],
        imageUrl: json['url'],
        author: json['author'],
        id: json['id'],
      );
}
