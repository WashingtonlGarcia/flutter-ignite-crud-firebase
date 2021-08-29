import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_repository.dart';

class FirestoreRepositoyImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;

  final String path;

  FirestoreRepositoyImpl({required this.firestore, required this.path});

  CollectionReference get collection => firestore.collection(path);

  @override
  Future<String> add({required Map<String, dynamic> data}) async {
    return (await collection.add(data)).id;
  }

  @override
  Future<void> remove({required String id}) {
    return collection.doc(id).delete();
  }

  @override
  Future<void> update({required String id, required Map<String, dynamic> data}) {
    return collection.doc(id).update(data);
  }

  @override
  Stream<List<Map<String, dynamic>>> read() {
    return collection
        .snapshots()
        .asyncMap((event) => event.docs.map((QueryDocumentSnapshot doc) => doc.data() as Map<String, dynamic>).toList())
        .asBroadcastStream();
  }

  @override
  Future<String> getId({required String key, required String value}) async {
    return (await collection.where(key, isEqualTo: value).get()).docs.single.id;
  }
}
