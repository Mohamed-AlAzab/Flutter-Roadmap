import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_roadmap/core/constant/collection_name.dart';
import 'package:flutter_roadmap/features/topic/data/models/topic_model.dart';
import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';
import 'package:flutter_roadmap/features/topic/domain/repository/topics_repository.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Topic>> fetchAlltTopicsFromSection(
    String courseId,
    String sectionId,
  ) async {
    final querySnapshot = await _firebaseFirestore
        .collection(coursesCollectionName)
        .doc(courseId)
        .collection(sectionsCollectionName)
        .doc(sectionId)
        .collection(topicsCollectionName)
        .orderBy(sectionOrderDocName, descending: false)
        .get();

    final topics = querySnapshot.docs.map((doc) {
      // ignore: unnecessary_cast
      final data = doc.data() as Map<String, dynamic>;
      // add function to get progress !
      return TopicModel.fromJson(data).toEntity(false);
    }).toList();

    return topics;
  }

  @override
  Future<String> addTopic(
    Topic topic,
    String courseId,
    String sectionId,
  ) async {
    try {
      final lastDoc = await _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(courseId)
          .collection(sectionsCollectionName)
          .doc(sectionId)
          .collection(topicsCollectionName)
          .orderBy(sectionOrderDocName, descending: true)
          .limit(1)
          .get();

      int nextOrder = 0;
      if (lastDoc.docs.isNotEmpty) {
        nextOrder = (lastDoc.docs.first[sectionOrderDocName] as int) + 1;
      }

      final doc = _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(courseId)
          .collection(sectionsCollectionName)
          .doc(sectionId)
          .collection(topicsCollectionName)
          .doc();

      TopicModel courseModel = TopicModel(
        id: doc.id,
        title: topic.title,
        order: nextOrder,
        description: topic.description,
        prerequisites: topic.prerequisites,
      );

      // add function to add progress !
      final querySnapshot = await doc.set(courseModel.toJson());

      return 'Topic Added Successfully';
    } catch (e) {
      throw Exception('Error to add course');
    }
  }

  @override
  Future<String> editTopic(
    Topic topic,
    String courseId,
    String sectionId,
  ) async {
    final docRef = _firebaseFirestore
        .collection(coursesCollectionName)
        .doc(courseId)
        .collection(sectionsCollectionName)
        .doc(sectionId)
        .collection(topicsCollectionName)
        .doc(topic.id);
    try {
      final doc = await docRef.get();

      if (!doc.exists) throw Exception('Section not found');

      final data = doc.data();
      int order;
      final rowrder = data?[topicOrderDocName];

      if (rowrder is int) {
        order = rowrder;
      } else {
        final lastDoc = await _firebaseFirestore
            .collection(coursesCollectionName)
            .doc(courseId)
            .collection(sectionsCollectionName)
            .orderBy(topicOrderDocName, descending: true)
            .limit(1)
            .get();

        order = lastDoc.docs.isNotEmpty
            ? (lastDoc.docs.first[topicOrderDocName] as int) + 1
            : 0;
      }

      TopicModel sectionModel = TopicModel(
        id: topic.id,
        title: topic.title,
        order: order,
        description: topic.description,
        prerequisites: topic.prerequisites,
      );

      // add function to add progress !
      await docRef.update(sectionModel.toJson());

      return 'Course edited';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> deleteTopic(
    String id,
    String courseId,
    String sectionId,
  ) async {
    try {
      // Todo: add delete subCollection function

      await _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(courseId)
          .collection(sectionsCollectionName)
          .doc(sectionId)
          .collection(topicsCollectionName)
          .doc(id)
          .delete();

      return 'Course deleted';
    } catch (e) {
      throw Exception('Error to deleted course');
    }
  }
}
