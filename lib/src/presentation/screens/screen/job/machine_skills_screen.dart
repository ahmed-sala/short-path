import 'package:flutter/material.dart';
import 'package:short_path/src/data/dto_models/career/extract_skills_dto.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';

class MachineSkillsScreen extends StatelessWidget {
  const MachineSkillsScreen({super.key, required this.extractedSkillsDto});

  final ExtractedSkillsDto extractedSkillsDto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Extracted Skills',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        shadowColor: AppColors.primaryColor.withOpacity(0.3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: extractedSkillsDto.data?.length ?? 0,
          itemBuilder: (context, index) {
            final skillItem = extractedSkillsDto.data![index];
            return SkillCard(
              skill: skillItem.skill ?? 'Unknown',
              rating: skillItem.rating ?? 0,
              contextText: skillItem.skillContext ?? '',
            );
          },
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String skill;
  final int rating;
  final String contextText;

  const SkillCard({
    super.key,
    required this.skill,
    required this.rating,
    required this.contextText,
  });

  @override
  Widget build(BuildContext context) {
    // Generate star icons
    final stars = List<Icon>.generate(
      5,
      (i) => Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: Colors.amber, // removed shade
        size: 18,
      ),
    );

    // Clean skill name by removing '#' characters
    final cleanSkill = skill.replaceAll('#', '');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          // e.g., navigate to detail
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primaryColor, // no shade
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cleanSkill,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor, // no shade
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(children: stars),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                contextText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey, // removed .shade700
                      letterSpacing: 0.25,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
