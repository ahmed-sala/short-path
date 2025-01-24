import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/skill_gathering/skill_list_widget.dart';

import '../../../../../dependency_injection/di.dart';
import '../../../mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';
import '../../widgets/infromation_gathering/skill_gathering/skill_input_widget.dart';

class TechnicalSkillScreen extends StatelessWidget {
  const TechnicalSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SkillGatheringViewmodel skillGatheringViewmodel =
        getIt<SkillGatheringViewmodel>();
    return BlocProvider(
      create: (context) => skillGatheringViewmodel,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Technical Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SkillInputWidget(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Skills',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            const SkillListWidget(),
          ],
        ),
      ),
    );
  }
}
