abstract class FirestoreRepository {
  Stream<List<Map<String, dynamic>>> read();

  Future<String> getId({required String key, required String value});

  Future<String> add({required Map<String, dynamic> data});

  Future<void> remove({required String id});

  Future<void> update({required String id, required Map<String, dynamic> data});
}
