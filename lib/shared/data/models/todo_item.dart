class ToDoItem {
  final String id;
  final String title;
  final bool state;

  ToDoItem({
    required this.id,
    required this.title,
    this.state = false,
  });

  factory ToDoItem.fromMap({required Map<String, dynamic> map}) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'state': state};
  }
}
