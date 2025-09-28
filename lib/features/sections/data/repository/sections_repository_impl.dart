import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_roadmap/core/constant/collection_name.dart';
import 'package:flutter_roadmap/features/sections/data/models/section_model.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/domain/repository/sections_repository.dart';

class SectionsRepositoryImpl implements SectionsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Section>> fetchAllSectionsFromCourse(String courseId) async {
    final querySnapshot = await _firebaseFirestore
        .collection(coursesCollectionName)
        .doc(courseId)
        .collection(sectionsCollectionName)
        .orderBy(sectionOrderDocName, descending: false)
        .get();

    final sections = querySnapshot.docs.map((doc) {
      // ignore: unnecessary_cast
      final data = doc.data() as Map<String, dynamic>;
      // add function to get progress !
      return SectionModel.fromJson(data).toEntity(0.2);
    }).toList();

    return sections;
  }

  @override
  Future<String> addSection(Section section, String courseId) async {
    try {
      final lastDoc = await _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(courseId)
          .collection(sectionsCollectionName)
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
          .doc();

      SectionModel courseModel = SectionModel(
        id: doc.id,
        title: section.title,
        order: nextOrder,
        description: section.description,
        prerequisites: section.prerequisites,
      );

      // add function to add progress !
      final querySnapshot = await doc.set(courseModel.toJson());

      return 'Course Added';
    } catch (e) {
      throw Exception('Error to add course');
    }
  }

  @override
  Future<String> editSection(Section section, String courseId) async {
    final docRef = _firebaseFirestore
        .collection(coursesCollectionName)
        .doc(courseId)
        .collection(sectionsCollectionName)
        .doc(section.id);
    try {
      final doc = await docRef.get();

      if (!doc.exists) throw Exception('Section not found');

      final data = doc.data();
      int order;
      final rowrder = data?[sectionOrderDocName];

      if (rowrder is int) {
        order = rowrder;
      } else {
        final lastDoc = await _firebaseFirestore
            .collection(coursesCollectionName)
            .doc(courseId)
            .collection(sectionsCollectionName)
            .orderBy('order', descending: true)
            .limit(1)
            .get();

        order = lastDoc.docs.isNotEmpty
            ? (lastDoc.docs.first['order'] as int) + 1
            : 0;
      }

      SectionModel sectionModel = SectionModel(
        id: section.id,
        title: section.title,
        order: order,
        description: section.description,
        prerequisites: section.prerequisites,
      );

      // add function to add progress !
      await docRef.update(sectionModel.toJson());

      return 'Course edited';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> deleteSection(String id, String courseId) async {
    try {
      // Todo: add delete subCollection function
      //

      await _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(courseId)
          .collection(sectionsCollectionName)
          .doc(id)
          .delete();

      return 'Course deleted';
    } catch (e) {
      throw Exception('Error to deleted course');
    }
  }
}
