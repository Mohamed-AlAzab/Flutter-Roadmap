import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/presentation/bloc/courses_bloc.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key, required this.courses});

  final List<Course> courses;

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController courseTitleController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();

  String? selectedIcon;
  List<String> selectedPrerequisitesId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Course'),
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
                            text: 'Course name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter course name';
                              }
                              return null;
                            },
                            controller: courseNameController,
                          ),
                          CoustomTextFormField(
                            text: 'Course title',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter course title';
                              }
                              return null;
                            },
                            controller: courseTitleController,
                          ),
                          CoustomTextFormField(
                            text: 'Course description',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter course description';
                              }
                              return null;
                            },
                            controller: courseDescriptionController,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Icon',
                            ),
                            value: selectedIcon,
                            items: ['dart', 'flutter', 'null']
                                .map(
                                  (icon) => DropdownMenuItem(
                                    value: icon,
                                    child: Text(icon),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              selectedIcon = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Prerequisites',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...[...widget.courses].map((option) {
                                final isChecked = selectedPrerequisitesId
                                    .contains(option.id);
                                return CheckboxListTile(
                                  title: Text(option.name),
                                  subtitle: Text(option.title),
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
                    child: CoustomButton(
                      text: 'Create',
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          context.read<CoursesBloc>().add(
                            AddCourseEvent(
                              Course(
                                id: '',
                                title: courseTitleController.text,
                                icon: selectedIcon ?? 'null',
                                name: courseNameController.text,
                                description: courseDescriptionController.text,
                                progress: 0.0,
                                prerequisites: selectedPrerequisitesId,
                              ),
                            ),
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            roadmapScreen,
                            (context) => false,
                          );
                        }
                      },
                      color: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.surface,
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
