import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_roadmap/core/constant/collection_name.dart';
import 'package:flutter_roadmap/features/courses/data/models/course_model.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Course>> fetchAllCourses() async {
    final querySnapshot = await _firebaseFirestore
        .collection(coursesCollectionName)
        .orderBy('order', descending: false)
        .get();

    final courseList = querySnapshot.docs.map((doc) {
      // ignore: unnecessary_cast
      final data = doc.data() as Map<String, dynamic>;

      // add function to get progress !
      return CourseModel.fromJson(data).toEntity(0.5);
    }).toList();

    return courseList;
  }

  @override
  Future<String> addCourse(Course course) async {
    try {
      final lastDoc = await _firebaseFirestore
          .collection(coursesCollectionName)
          .orderBy('order', descending: true)
          .limit(1)
          .get();

      int nextOrder = 0;
      if (lastDoc.docs.isNotEmpty) {
        nextOrder = (lastDoc.docs.first['order'] as int) + 1;
      }

      final doc = _firebaseFirestore.collection(coursesCollectionName).doc();

      CourseModel courseModel = CourseModel(
        id: doc.id,
        title: course.title,
        icon: course.icon,
        name: course.name,
        order: nextOrder,
        description: course.description,
        prerequisites: course.prerequisites,
      );

      // add function to add progress !
      final querySnapshot = await doc.set(courseModel.toJson());

      return 'Course Added';
    } catch (e) {
      throw Exception('Error to add course');
    }
  }

  @override
  Future<String> editCourse(Course course) async {
    final docRef = _firebaseFirestore
        .collection(coursesCollectionName)
        .doc(course.id);
    try {
      final doc = await docRef.get();

      if (!doc.exists) throw Exception('Course not found');

      final data = doc.data();
      int order;
      final rowrder = data?['order'];

      if (rowrder is int) {
        order = rowrder;
      } else {
        final lastDoc = await _firebaseFirestore
            .collection(coursesCollectionName)
            .orderBy('order', descending: true)
            .limit(1)
            .get();

        order = lastDoc.docs.isNotEmpty
            ? (lastDoc.docs.first['order'] as int) + 1
            : 0;
      }

      CourseModel courseModel = CourseModel(
        id: course.id,
        title: course.title,
        icon: course.icon,
        name: course.name,
        order: order,
        description: course.description,
        prerequisites: course.prerequisites,
      );

      // add function to add progress !
      await docRef.update(courseModel.toJson());

      return 'Course edited';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> deleteCourse(String id) async {
    try {
      // Todo: add delete subCollection function

      await _firebaseFirestore
          .collection(coursesCollectionName)
          .doc(id)
          .delete();

      return 'Course deleted';
    } catch (e) {
      throw Exception('Error to deleted course');
    }
  }
}
