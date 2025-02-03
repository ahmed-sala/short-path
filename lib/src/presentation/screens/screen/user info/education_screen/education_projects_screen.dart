import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';

class EducationProjectsScreen extends StatelessWidget {
  const EducationProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<EducationViewmodelNew>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Projects'),
      ),
      body: Center(
        child: BlocConsumer<EducationViewmodelNew, EducationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    viewModel.addEducation();
                  },
                  child: Text('Add Education'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
