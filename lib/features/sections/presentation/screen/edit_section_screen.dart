import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/get_it/get_it.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/presentation/bloc/sections_bloc.dart';

class EditSectionScreen extends StatefulWidget {
  const EditSectionScreen({
    super.key,
    required this.section,
    required this.sections,
    required this.course,
  });

  final Course course;
  final Section section;
  final List<Section> sections;

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController sectionTitleController = TextEditingController();
  TextEditingController sectionDescriptionController = TextEditingController();
  String? selectedIcon;
  List<String> selectedPrerequisitesId = [];

  @override
  void initState() {
    super.initState();
    selectedPrerequisitesId = widget.section.prerequisites;
    sectionTitleController.text = widget.section.title;
    sectionDescriptionController.text = widget.section.description;
  }

  @override
  void dispose() {
    sectionTitleController.dispose();
    sectionDescriptionController.dispose();
    super.dispose();
  }

  Section _returnSection() {
    return Section(
      id: widget.section.id,
      title: sectionTitleController.text,
      description: sectionDescriptionController.text,
      progress: 0.0,
      prerequisites: selectedPrerequisitesId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Edit Course'),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Form(
            key: _key,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Positioned.fill(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CoustomTextFormField(
                            text: 'Course title',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter course title';
                              }
                              return null;
                            },
                            controller: sectionTitleController,
                          ),
                          CoustomTextFormField(
                            text: 'Course description',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter course description';
                              }
                              return null;
                            },
                            controller: sectionDescriptionController,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Prerequisites',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...[...widget.sections].map((option) {
                                final isChecked = selectedPrerequisitesId
                                    .contains(option.id);
                                return CheckboxListTile(
                                  title: Text(option.title),
                                  value: isChecked,
                                  onChanged: (checked) {
                                    if (checked == true) {
                                      selectedPrerequisitesId.add(option.id);
                                    } else {
                                      selectedPrerequisitesId.remove(option.id);
                                    }
                                    setState(() {});
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                );
                              }).toList(),
                            ],
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20,
                    ),
                    child: BlocProvider(
                      create: (_) => getIt<SectionsBloc>(),
                      child: Builder(
                        builder: (context) => CoustomButton(
                          text: 'Edit',
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              context.read<SectionsBloc>().add(
                                EditSectionEvent(
                                  _returnSection(),
                                  widget.course.id,
                                ),
                              );
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                sectionsScreen,
                                arguments: widget.course,
                                (route) => Navigator.of(context).canPop()
                                    ? route.isFirst
                                    : false,
                              );
                            }
                          },
                          color: Theme.of(context).colorScheme.onSurface,
                          textColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
