import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterviewPreparationScreen extends StatelessWidget {
  final List<String> questions;
  final List<String> answers;
  final String? jobTitle;
  final int? jobId;

  const InterviewPreparationScreen({
    super.key,
    required this.questions,
    required this.answers,
    this.jobTitle,
    this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    final List<InterviewQuestion> interviewQuestions = List.generate(
      questions.length,
      (index) => InterviewQuestion(
        question: questions[index],
        answer:
            index < answers.length ? answers[index] : 'No answer available.',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          jobTitle != null ? ' $jobTitle' : 'Interview Preparation',
          style: TextStyle(
            fontSize: 16.sp,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...interviewQuestions.map(_buildQuestionCard),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(InterviewQuestion question) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              question.answer,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class InterviewQuestion {
  final String question;
  final String answer;

  InterviewQuestion({
    required this.question,
    required this.answer,
  });
}
