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

  // Future<void> addAllSections(String courseId) async {
  //   final List<Map<String, String>> content = [
  //     {
  //       "title": "Introduction to Object-Oriented Programming",
  //       "text":
  //           "Understand the core OOP concepts—objects, classes, and how Dart uses them to structure code.",
  //     },
  //     {
  //       "title": "Classes and Objects",
  //       "text":
  //           "Learn how to define classes, create objects, and use fields and methods to organize data and behavior.",
  //     },
  //     {
  //       "title": "Constructors and Named Constructors",
  //       "text":
  //           "Discover how to initialize objects using default, named, and factory constructors.",
  //     },
  //     {
  //       "title": "Encapsulation and Getters/Setters",
  //       "text":
  //           "Protect data inside a class using private members, getters, setters, and custom logic.",
  //     },
  //     {
  //       "title": "Inheritance",
  //       "text":
  //           "Reuse and extend functionality by creating subclasses and overriding methods.",
  //     },
  //     {
  //       "title": "Polymorphism",
  //       "text":
  //           "Write flexible code using method overriding and dynamic behavior across related classes.",
  //     },
  //     {
  //       "title": "Abstract Classes and Interfaces",
  //       "text":
  //           "Create blueprints for other classes and enforce contracts with abstract methods and interfaces.",
  //     },
  //     {
  //       "title": "Mixins",
  //       "text":
  //           "Add shared functionality to multiple classes without using traditional inheritance.",
  //     },
  //     {
  //       "title": "Generics in OOP",
  //       "text":
  //           "Use type parameters to build reusable, type-safe classes and methods.",
  //     },
  //     {
  //       "title": "OOP Project",
  //       "text":
  //           "Apply everything you learned by building a small real-world application that uses classes, inheritance, and polymorphism.",
  //     },
  //   ];
  //   // Insert one by one in order
  //   for (var i = 0; i < content.length; i++) {
  //     await addSection(
  //       Section(
  //         id: '',
  //         title: content[i]['title'] ?? '',
  //         description: content[i]['text'] ?? '',
  //         progress: 0.0,
  //         prerequisites: [],
  //       ),
  //       courseId,
  //     );
  //   }
  // }
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
