// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../data/products_repository.dart';

class Search {
  Search({
    this.id,
    required this.title,
  });

  String? id;
  final String title;

  factory Search.fromMap(Map<String, dynamic>? map) {
    if (map == null) return throw Exception();

    return Search(
      id: map['id'],
      title: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
    };
  }

  @override
  String toString() => 'Search(id: $id, name: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Search && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
