import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> addDocument(
      String collectionPath, Map<String, dynamic> data, String id) async {
    try {
      print('Attempting to add document to $collectionPath');
      var docRef =
          await _firestore.collection(collectionPath).doc(id).set(data);
    } catch (e) {
      print('Error adding document: $e');
      throw Exception('Error adding document: $e');
    }
  }

  Future<DocumentReference> addNormalDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      print('Attempting to add document to $collectionPath');
      return await _firestore.collection(collectionPath).add(data);
    } catch (e) {
      print('Error adding document: $e');
      throw Exception('Error adding document: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDocuments(String collectionPath) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching documents: $e');
    }
  }

  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(data);
    } catch (e) {
      throw Exception('Error updating document: $e');
    }
  }

  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  Future<bool> deleteDocumentByField(
    String collectionPath,
    String field,
    dynamic value,
  ) async {
    try {
      // find the first matching document
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return false;

      // delete it
      await querySnapshot.docs.first.reference.delete();
      return true;
    } catch (e) {
      throw Exception('Error deleting document by field: $e');
    }
  }

  Future<Map<String, dynamic>?> getDocumentById(
      String collectionPath, String docId) async {
    try {
      final docSnapshot =
          await _firestore.collection(collectionPath).doc(docId).get();
      return docSnapshot.exists ? docSnapshot.data() : null;
    } catch (e) {
      throw Exception('Error fetching document by ID: $e');
    }
  }

  Future<Map<String, dynamic>?> getDocumentByField(
      String collectionPath, String field, dynamic value) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .limit(1) // Limit to first match
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var data = doc.data();
        data['firestore_doc_id'] =
            doc.id; // Store Firestore document ID in the result
        return data;
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching document by field: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllDocumentsByField(
      String collectionPath, String field, dynamic value) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching documents by field: $e');
    }
  }

  Future<String> getIdByField(
      String collectionPath, String field, dynamic value) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .limit(1) // Limit to first match
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        return doc.id;
      }
      return '';
    } catch (e) {
      throw Exception('Error fetching document by field: $e');
    }
  }

  Stream<Map<String, dynamic>?> documentStream(
      String collectionPath, String docId) {
    return _firestore
        .collection(collectionPath)
        .doc(docId)
        .snapshots()
        .map((snapshot) => snapshot.exists ? snapshot.data() : null);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getQuerySnapshotsByField(
    String collectionPath,
    String field,
    dynamic value,
  ) async {
    final snapshot = await _firestore
        .collection(collectionPath)
        .where(field, isEqualTo: value)
        .get();
    return snapshot.docs;
  }
}
