import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:flutter_roadmap/features/courses/presentation/widget/add_course_button.dart';
import 'package:flutter_roadmap/features/courses/presentation/widget/courses_card.dart';
import 'package:flutter_roadmap/features/courses/presentation/widget/shimmer_courses_card.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  bool isAdmin = false;

  List<Course> courses = [];

  @override
  void initState() {
    isAdminFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Roadmap'),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CoursesBloc>().add(GetCoursesEvent());
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, state) {
                  if (state is CoursesLoading) {
                    return Column(
                      children: [
                        ShimmerCoursesCard(),
                        SizedBox(height: 16),
                        ShimmerCoursesCard(),
                        SizedBox(height: 16),
                        ShimmerCoursesCard(),
                      ],
                    );
                  }
                  if (state is CoursesLoaded) {
                    courses = state.courses;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CoursesCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                sectionsScreen,
                                arguments: state.courses[index],
                              );
                            },
                            onLongPress: isAdmin
                                ? () => _onLongPress(
                                    // edit
                                    () {
                                      Navigator.pushNamed(
                                        context,
                                        editCourseScreen,
                                        arguments: {
                                          'courses': courses,
                                          'course': state.courses[index],
                                        },
                                      );
                                    },
                                    // delete
                                    () {
                                      context.read<CoursesBloc>().add(
                                        DeleteCourseEvent(
                                          state.courses[index].id,
                                        ),
                                      );
                                    },
                                  )
                                : () {},
                            course: state.courses[index],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: state is CoursesError
                        ? Text(state.message)
                        : Text('An error occurred.'),
                  );
                },
              ),
            ),
            if (isAdmin)
              Padding(
                padding: const EdgeInsets.only(left: 48, right: 48, bottom: 16),
                child: BlocConsumer<CoursesBloc, CoursesState>(
                  listener: (context, state) {
                    if (state is CoursesError) {
                      Message(
                        color: Colors.red,
                        context: context,
                        message: state.message,
                      );
                    }
                    if (state is CoursesAdded) {
                      Message(
                        color: Colors.green,
                        context: context,
                        message: state.message,
                      );
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    return AddCourseButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          addCourseScreen,
                          arguments: courses,
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(index: 0),
    );
  }

  void _onLongPress(
    void Function() onTapToEdit,
    void Function() onTapToDelete,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (scontext) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose an option',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Edit',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(scontext);
                  Future.microtask(() {
                    onTapToEdit();
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () async {
                  final shouldDelete = await showDeleteConfirmationDialog(
                    scontext,
                  );
                  if (shouldDelete == true) {
                    onTapToDelete();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(scontext);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item?'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future isAdminFunc() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      isAdmin = user['role'] == "admin";
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
