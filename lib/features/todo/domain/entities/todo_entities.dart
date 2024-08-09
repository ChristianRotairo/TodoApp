class Task {
  final int? id;
  final String? todo;
  bool? status;

  Task({
    this.id,
    this.todo,
    this.status,
  });

  // Instance method to create a Task instance from a map
  Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      todo: map['todo'],
      status: map['status'] == 1,
    );
  }

  // Method to convert a Task instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'status': status! ? 1 : 0,
    };
  }
}
