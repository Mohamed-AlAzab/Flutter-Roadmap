import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/get_it/get_it.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/topic/presentation/bloc/topics_bloc.dart';
import 'package:flutter_roadmap/features/topic/presentation/widget/topic_card.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key, required this.course, required this.section});
  final Course course;
  final Section section;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TopicsBloc>()
        ..add(GetAllTopicsEvent(courseId: course.id, sectionId: section.id)),
      child: TopicsView(course: course, section: section),
    );
  }
}

class TopicsView extends StatefulWidget {
  const TopicsView({super.key, required this.course, required this.section});
  final Course course;
  final Section section;

  @override
  State<TopicsView> createState() => _TopicsViewState();
}

class _TopicsViewState extends State<TopicsView> {
  bool isAdmin = false;

  @override
  void initState() {
    _isAdminFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: widget.section.title),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TopicsBloc>().add(
            GetAllTopicsEvent(
              courseId: widget.course.id,
              sectionId: widget.section.id,
            ),
          );
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    widget.section.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: context.width,
                  child: Text(
                    widget.section.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                BlocConsumer<TopicsBloc, TopicsState>(
                  listener: (context, state) {
                    if (state is TopicError) {
                      Message(
                        context: context,
                        message: state.message,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is TopicsLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.topics.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TopicCard(
                              onTap: () {
                                Navigator.pushNamed(context, topicScreen);
                              },
                              title: state.topics[index].title,
                              text: state.topics[index].description,
                            ),
                          );
                        },
                      );
                    }
                    if (state is TopicsLoading) {
                      return Container();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Message(
                  context: context,
                  message: 'In Progress',
                  color: Colors.grey,
                );
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: CoustomBottomNavigationBar(),
    );
  }

  Future _isAdminFunc() async {
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
