import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterviewPreparationScreen extends StatefulWidget {
  final int jobId;
  final String? initialJobTitle;

  const InterviewPreparationScreen({
    super.key,
    required this.jobId,
    this.initialJobTitle,
  });

  @override
  State<InterviewPreparationScreen> createState() => _InterviewPreparationScreenState();
}

class _InterviewPreparationScreenState extends State<InterviewPreparationScreen> {
  bool _isLoading = false;
  List<InterviewQuestion> _questions = [];
  List<String> _tips = [];
  String? _jobTitle;

  @override
  void initState() {
    super.initState();
    _jobTitle = widget.initialJobTitle;
    _loadInterviewData();
  }

  Future<void> _loadInterviewData() async {
    setState(() => _isLoading = true);

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // In a real app, you would call your API here
      // final response = await InterviewService.getQuestions(widget.jobId);
      // setState(() {
      //   _questions = response.questions;
      //   _tips = response.tips;
      //   _jobTitle = response.jobTitle ?? widget.initialJobTitle;
      // });

      // Mock data based on jobId
      final mockData = _generateMockData(widget.jobId);
      setState(() {
        _questions = mockData.questions;
        _tips = mockData.tips;
        _isLoading = false;
      });

    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading questions: $e')),
      );
    }
  }

  InterviewData _generateMockData(int jobId) {
    // This is just sample data - replace with real API calls
    switch (jobId % 3) {
      case 0: // Flutter Developer
        return InterviewData(
          questions: [
            InterviewQuestion(
              question: 'Explain the widget lifecycle in Flutter',
              answer: 'The widget lifecycle includes createState, initState, '
                  'didChangeDependencies, build, didUpdateWidget, and dispose.',
              tip: 'Mention how you\'ve used these in real projects',
            ),
            InterviewQuestion(
              question: 'How do you optimize Flutter app performance?',
              answer: 'I use const widgets, avoid unnecessary rebuilds, and '
                  'implement efficient state management solutions.',
            ),
          ],
          tips: [
            'Bring examples of your Flutter projects',
            'Be prepared to discuss state management approaches',
          ],
          jobTitle: 'Flutter Developer',
        );
      case 1: // Product Manager
        return InterviewData(
          questions: [
            InterviewQuestion(
              question: 'How do you prioritize features?',
              answer: 'I use the RICE scoring model (Reach, Impact, Confidence, Effort) '
                  'combined with business objectives.',
              tip: 'Reference specific prioritization tools you\'ve used',
            ),
          ],
          tips: [
            'Prepare case studies from past product launches',
            'Bring metrics showing your impact',
          ],
          jobTitle: 'Product Manager',
        );
      default:
        return InterviewData(
          questions: [
            InterviewQuestion(
              question: 'Tell us about yourself',
              answer: 'Focus on relevant experience for this position.',
            ),
          ],
          tips: [
            'Research the company thoroughly',
            'Prepare questions to ask the interviewer',
          ],
          jobTitle: widget.initialJobTitle ?? 'This Position',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _jobTitle != null ? ' $_jobTitle' : 'Interview Preparation',
          style: TextStyle(
            fontSize: 16.sp, // Reduced font size
            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? _buildLoadingView()
          : _buildContent(),

    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            'Preparing questions for Job #${widget.jobId}...',
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interview Preparation',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),

          SizedBox(height: 24.h),

          if (_questions.isEmpty)
            _buildEmptyState()
          else
            ..._questions.map((q) => _buildQuestionCard(q)).toList(),

          SizedBox(height: 24.h),
          _buildTipsSection(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Icon(Icons.hourglass_empty, size: 48.w, color: Colors.grey),
        SizedBox(height: 16.h),
        Text(
          'No questions available',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
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
            if (question.tip != null) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: Colors.amber[700], size: 20.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        question.tip!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.amber[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General Tips',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        ..._tips.map((tip) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  tip,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}

// Data Models
class InterviewQuestion {
  final String question;
  final String answer;
  final String? tip;

  InterviewQuestion({
    required this.question,
    required this.answer,
    this.tip,
  });
}

class InterviewData {
  final List<InterviewQuestion> questions;
  final List<String> tips;
  final String? jobTitle;

  InterviewData({
    required this.questions,
    required this.tips,
    this.jobTitle,
  });
}