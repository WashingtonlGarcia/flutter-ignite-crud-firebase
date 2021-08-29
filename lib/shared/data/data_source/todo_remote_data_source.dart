import '../models/todo_item.dart';
import '../../infra/firebase/firestore_repository.dart';

import '../interfaces/todo_data_source_interface.dart';

class TodoRemoteDataSource implements ToDoDataSourceInterface {
  final FirestoreRepository repository;

  TodoRemoteDataSource({required this.repository});

  @override
  Stream<List<ToDoItem>?> fetchToDoListStream() {
    return repository.read().asyncMap((event) => event.map((Map<String, dynamic> map) => ToDoItem.fromMap(map: map)).toList());
  }

  @override
  Future<void> onAddToDoItem(ToDoItem item) {
    return repository.add(data: item.toMap());
  }

  @override
  Future<void> onRemoveToDoItem(String uid) async {
    final String id = (await repository.getId(key: 'id', value: uid));
    await repository.remove(id: id);
  }

  @override
  Future<void> onToogleToDoItemState(String uid, bool state) async {
    final String id = (await repository.getId(key: 'id', value: uid));
    await repository.update(id: id, data: {'state': state});
  }
}
