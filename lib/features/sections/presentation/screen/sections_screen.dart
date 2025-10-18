import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/get_it/get_it.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/presentation/bloc/sections_bloc.dart';
import 'package:flutter_roadmap/features/sections/presentation/widget/section_card.dart';
import 'package:flutter_roadmap/features/sections/presentation/widget/shimmer_section_card.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SectionsBloc>()..add(GetSectionsEvent(course.id)),
      child: SectionsView(course: course),
    );
  }
}

class SectionsView extends StatefulWidget {
  const SectionsView({super.key, required this.course});

  final Course course;

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  bool isAdmin = false;
  List<Section> sections = [];

  @override
  void initState() {
    _isAdminFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: widget.course.title),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SectionsBloc>().add(GetSectionsEvent(widget.course.id));
        },
        child: BlocBuilder<SectionsBloc, SectionsState>(
          builder: (context, state) {
            if (state is SectionsLoaded) {
              sections = state.sections;
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.sections.length,
                itemBuilder: (context, index) {
                  return SectionCard(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        topicsScreen,
                        arguments: {
                          'course': widget.course,
                          'section': state.sections[index],
                        },
                      );
                    },
                    onLongPress: () {
                      _onLongPress(
                        // Edit
                        () {
                          Navigator.pushNamed(
                            context,
                            editSectionScreen,
                            arguments: {
                              'course': widget.course,
                              'sections': state.sections,
                              'section': state.sections[index],
                            },
                          );
                        },
                        // Delete
                        () {
                          context.read<SectionsBloc>().add(
                            DeleteSectionEvent(
                              state.sections[index].id,
                              widget.course.id,
                            ),
                          );
                        },
                      );
                    },
                    title: state.sections[index].title,
                    text: state.sections[index].description,
                    progress: state.sections[index].progress,
                  );
                },
              );
            }
            if (state is SectionsLoading) {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (_, _) => ShimmerSectionCard(),
              );
            }
            return Center(
              child: Text(state is SectionsError ? state.message : 'Error'),
            );
          },
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  addSectionScreen,
                  arguments: {'course': widget.course, 'sections': sections},
                );
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: CoustomBottomNavigationBar(),
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
        title: const Text('Delete Section?'),
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
