class Todo {
  Todo({
    this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
  });

  int? id; // optional id.
  final String title;
  final String creationDate;
  bool isChecked;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creationDate': creationDate,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, creationDate: $creationDate, isChecked: $isChecked';
  }
}
