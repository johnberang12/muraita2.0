// ignore_for_file: public_member_api_docs, sort_constructors_first
class Search {
  Search({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Search.fromMap(Map<String, dynamic>? map) {
    if (map == null) return throw Exception();

    return Search(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'Search(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Search && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
