import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  final _degreeController = TextEditingController();
  final _fieldOfStudyController = TextEditingController();
  final _startDateMonthController = TextEditingController();
  final _startDateYearController = TextEditingController();
  final _endDateMonthController = TextEditingController();
  final _endDateYearController = TextEditingController();

  // Lists for month and year suggestions
  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  final List<String> _years = List.generate(101, (index) => (1925 + index).toString());

  // Filtered suggestions for months and years
  List<String> filteredStartMonths = [];
  List<String> filteredStartYears = [];
  List<String> filteredEndMonths = [];
  List<String> filteredEndYears = [];

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    filteredStartMonths = _months;
    filteredStartYears = _years;
    filteredEndMonths = _months;
    filteredEndYears = _years;

    _schoolController.addListener(_validateForm);
    _degreeController.addListener(_validateForm);
    _fieldOfStudyController.addListener(_validateForm);
    _startDateMonthController.addListener(() => _onStartMonthChanged());
    _startDateYearController.addListener(() => _onStartYearChanged());
    _endDateMonthController.addListener(() => _onEndMonthChanged());
    _endDateYearController.addListener(() => _onEndYearChanged());
  }

  void _onStartMonthChanged() {
    setState(() {
      if (_startDateMonthController.text.isEmpty) {
        filteredStartMonths = _months;
      } else {
        filteredStartMonths = _months
            .where((month) =>
            month.toLowerCase().startsWith(_startDateMonthController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _onStartYearChanged() {
    setState(() {
      if (_startDateYearController.text.isEmpty) {
        filteredStartYears = _years;
      } else {
        filteredStartYears = _years
            .where((year) =>
            year.startsWith(_startDateYearController.text))
            .toList();
      }
    });
  }

  void _onEndMonthChanged() {
    setState(() {
      if (_endDateMonthController.text.isEmpty) {
        filteredEndMonths = _months;
      } else {
        filteredEndMonths = _months
            .where((month) =>
            month.toLowerCase().startsWith(_endDateMonthController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _onEndYearChanged() {
    setState(() {
      if (_endDateYearController.text.isEmpty) {
        filteredEndYears = _years;
      } else {
        filteredEndYears = _years
            .where((year) =>
            year.startsWith(_endDateYearController.text))
            .toList();
      }
    });
  }

  void _validateForm() {
    setState(() {
      _validate = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _startDateMonthController.dispose();
    _startDateYearController.dispose();
    _endDateMonthController.dispose();
    _endDateYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(top: 30.0), // Add space above the title
          child: Text('Education Details'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Form(
            key: _formKey,
            onChanged: _validateForm,
            child: Column(
              children: [
                Text(
                  'Add Your Education',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Fill in your education details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                verticalSpace(30),
                CustomTextFormField(
                  hintText: 'university/school',
                  keyboardType: TextInputType.text,
                  controller: _schoolController,
                  labelText: 'University/School',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your school/university';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  hintText: 'Enter your degree',
                  keyboardType: TextInputType.text,
                  controller: _degreeController,
                  labelText: 'Degree',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your degree';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  hintText: 'Ex: Business',
                  keyboardType: TextInputType.text,
                  controller: _fieldOfStudyController,
                  labelText: 'Field of Study',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your field of study';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Month',
                            keyboardType: TextInputType.text,
                            controller: _startDateMonthController,
                            labelText: 'Start Date (Month)',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter the start month';
                              }
                              return null;
                            },
                          ),
                          if (filteredStartMonths.isNotEmpty && _startDateMonthController.text.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredStartMonths.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(filteredStartMonths[index]),
                                    onTap: () {
                                      setState(() {
                                        _startDateMonthController.text = filteredStartMonths[index]; // Set the selected month
                                        filteredStartMonths = []; // Clear the suggestions list
                                        FocusScope.of(context).unfocus(); // Remove focus from the text field
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Year',
                            keyboardType: TextInputType.number,
                            controller: _startDateYearController,
                            labelText: 'Start Date (Year)',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter the start year';
                              }
                              return null;
                            },
                          ),
                          if (filteredStartYears.isNotEmpty && _startDateYearController.text.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredStartYears.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(filteredStartYears[index]),
                                    onTap: () {
                                      setState(() {
                                        _startDateYearController.text = filteredStartYears[index]; // Set the selected year
                                        filteredStartYears = []; // Clear the suggestions list
                                        FocusScope.of(context).unfocus(); // Remove focus from the text field
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Month',
                            keyboardType: TextInputType.text,
                            controller: _endDateMonthController,
                            labelText: 'End Date (Month)',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter the end month';
                              }
                              return null;
                            },
                          ),
                          if (filteredEndMonths.isNotEmpty && _endDateMonthController.text.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredEndMonths.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(filteredEndMonths[index]),
                                    onTap: () {
                                      setState(() {
                                        _endDateMonthController.text = filteredEndMonths[index]; // Set the selected month
                                        filteredEndMonths = []; // Clear the suggestions list
                                        FocusScope.of(context).unfocus(); // Remove focus from the text field
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Year',
                            keyboardType: TextInputType.number,
                            controller: _endDateYearController,
                            labelText: 'End Date (Year)',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter the end year';
                              }
                              return null;
                            },
                          ),
                          if (filteredEndYears.isNotEmpty && _endDateYearController.text.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredEndYears.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(filteredEndYears[index]),
                                    onTap: () {
                                      setState(() {
                                        _endDateYearController.text = filteredEndYears[index]; // Set the selected year
                                        filteredEndYears = []; // Clear the suggestions list
                                        FocusScope.of(context).unfocus(); // Remove focus from the text field
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                CustomAuthButton(
                  text: 'NEXT',
                  onPressed: () {
                    // Validate all fields
                    if (_formKey.currentState!.validate()) {
                      // If all fields are valid, navigate to the next screen
                    } else {
                      // If validation fails, show an error message or handle it as needed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all required fields correctly.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  color: _validate ? AppColors.primaryColor : const Color(0xFF5C6673),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}