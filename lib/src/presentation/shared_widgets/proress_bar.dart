import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final List<String> stepNames = [
    "Info",
    "Skills",
    "Education",
    "Experience",
    "Projects",
    "Certifications",
    "Additional"
  ];

  StepProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    int totalSteps = stepNames.length;

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps * 2 - 1, (index) {
            if (index.isEven) {
              int stepNumber = (index ~/ 2) + 1;
              bool isCompleted = stepNumber < currentStep;
              bool isCurrent = stepNumber == currentStep;

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: isCurrent
                          ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ]
                          : [],
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isCompleted
                          ? Colors.green
                          : isCurrent
                          ? Colors.orange
                          : Colors.grey.shade400,
                      child: Text(
                        "$stepNumber",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (isCurrent) ...[
                    const SizedBox(height: 6),
                    Text(
                      stepNames[stepNumber - 1],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              );
            } else {
              bool isCompleted = (index ~/ 2) + 1 < currentStep;

              return Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? const LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
                    )
                        : null,
                    color: isCompleted ? null : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
