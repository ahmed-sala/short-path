import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../short_path.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _languageController = TextEditingController(); // For adding new languages
  String? _selectedLanguageLevel; // For selecting language level
  final List<String> _languageLevels = ['Beginner', 'Intermediate', 'Advanced']; // Language levels

  // List to store added languages and their levels
  final List<Map<String, String>> _languages = [];

  // Job suggestions list
  List<String> jobSuggestions = [
    "Frontend Developer",
    "Backend Developer",
    "Full Stack Developer",
    "Mobile App Developer",
    "iOS Developer",
    "Android Developer",
    "Flutter Developer",
    "React Native Developer",
    "Web Developer",
    "JavaScript Developer",
    "Python Developer",
    "Java Developer",
    "C# Developer",
    "PHP Developer",
    "Ruby Developer",
    "Go Developer",
    "DevOps Engineer",
    "Cloud Engineer",
    "Data Engineer",
    "Machine Learning Engineer",
    "AI Developer",
    "Game Developer",
    "Unity Developer",
    "Embedded Systems Developer",
    "Blockchain Developer",
    "Software Architect",
    "UI/UX Developer",
    "QA Engineer",
    "Automation Engineer",
    "Security Engineer",
    "Systems Developer",
    "Database Developer",
    "API Developer",
    "WordPress Developer",
    "Shopify Developer",
    "E-commerce Developer",
    "AR/VR Developer",
    "IoT Developer",
    "Firmware Developer",
    "Technical Lead",
    "Scrum Master",
    "Agile Coach",
    "Product Owner",
    "Technical Writer",
    "Solutions Architect",
    "Site Reliability Engineer (SRE)",
    "Data Scientist",
    "Big Data Developer",
    "Cloud Solutions Developer",
    "Kotlin Developer",
    "Swift Developer",
    "Rust Developer",
    "TypeScript Developer",
    "Node.js Developer",
    "Django Developer",
    "Laravel Developer",
    "Spring Boot Developer",
    "Angular Developer",
    "Vue.js Developer",
    "React Developer",
    "Svelte Developer",
    "GraphQL Developer",
    "REST API Developer",
    "Microservices Developer",
    "Serverless Developer",
    "Kubernetes Developer",
    "Docker Developer",
    "CI/CD Engineer",
    "Performance Engineer",
    "Scala Developer",
    "Elixir Developer",
    "Erlang Developer",
    "Haskell Developer",
    "Perl Developer",
    "Shell Script Developer",
    "PowerShell Developer",
    "Bash Script Developer",
    "Low-Code Developer",
    "No-Code Developer",
    "RPA Developer (Robotic Process Automation)",
    "Chatbot Developer",
    "Voice Assistant Developer",
    "NLP Developer (Natural Language Processing)",
    "Computer Vision Developer",
    "Quantum Computing Developer",
    "Edge Computing Developer",
    "5G Developer",
    "Cybersecurity Developer",
    "Penetration Tester",
    "Ethical Hacker",
    "Digital Forensics Developer",
    "Cryptography Developer",
    "Distributed Systems Developer",
    "Real-Time Systems Developer",
    "High-Frequency Trading Developer",
    "FinTech Developer",
    "HealthTech Developer",
    "EdTech Developer",
    "AgriTech Developer",
    "CleanTech Developer",
    "SpaceTech Developer",
    "Autonomous Systems Developer",
    "Robotics Developer",
    "Drone Developer",
    "Wearable Tech Developer",
    "Smart Home Developer",
    "Smart City Developer",
    "Digital Twin Developer",
    "Metaverse Developer",
    "NFT Developer",
    "Web3 Developer",
    "DeFi Developer (Decentralized Finance)",
    "Smart Contract Developer",
    "Solidity Developer",
    "Ethereum Developer",
    "Hyperledger Developer",
    "IPFS Developer",
    "Decentralized App (DApp) Developer",
    "Open Source Contributor",
    "Freelance Developer",
    "Remote Developer",
    "Consultant Developer",
    "Startup Developer",
    "Enterprise Developer",
    "Government Developer",
    "Non-Profit Developer",
  ];
  List<String> filteredJobSuggestions = [];

  // Language suggestions list
  List<String> languageSuggestions = [
    "English",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Japanese",
    "Arabic",
    "Russian",
    "Portuguese",
    "Italian",
    "Hindi",
    "Korean",
    "Turkish",
    "Dutch",
    "Swedish",
    "Polish",
    "Vietnamese",
    "Thai",
    "Greek",
    "Hebrew",
  ];
  List<String> filteredLanguageSuggestions = [];

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    filteredJobSuggestions = jobSuggestions;
    filteredLanguageSuggestions = languageSuggestions;
    _jobTitleController.addListener(_onJobTitleChanged);
    _nameController.addListener(_validateForm);
    _jobTitleController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _languageController.addListener(_onLanguageChanged);
  }

  void _onJobTitleChanged() {
    setState(() {
      if (_jobTitleController.text.isEmpty) {
        filteredJobSuggestions = jobSuggestions;
      } else {
        filteredJobSuggestions = jobSuggestions
            .where((job) =>
            job.toLowerCase().startsWith(_jobTitleController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _onLanguageChanged() {
    setState(() {
      if (_languageController.text.isEmpty) {
        filteredLanguageSuggestions = languageSuggestions;
      } else {
        filteredLanguageSuggestions = languageSuggestions
            .where((language) =>
            language.toLowerCase().startsWith(_languageController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _validateForm() {
    setState(() {
      _validate = _formKey.currentState?.validate() ?? false;
    });
  }

  // Add a new language and level to the list
  void _addLanguage() {
    if (_languageController.text.isNotEmpty && _selectedLanguageLevel != null) {
      setState(() {
        _languages.add({
          'language': _languageController.text,
          'level': _selectedLanguageLevel!,
        });
        _languageController.clear(); // Clear the text field
        _selectedLanguageLevel = null; // Reset the dropdown
        filteredLanguageSuggestions = languageSuggestions; // Reset language suggestions
      });
    }
  }

  // Remove a language from the list
  void _removeLanguage(int index) {
    setState(() {
      _languages.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(top: 30.0), // Add space above the title
          child: Text('Personal Details'),
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
                  'Create Your CV',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Fill in your details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                verticalSpace(30),
                CustomTextFormField(
                  hintText: 'Enter your job title',
                  keyboardType: TextInputType.text,
                  controller: _jobTitleController,
                  labelText: 'Job Title',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your job title';
                    }
                    return null;
                  },
                ),
                if (filteredJobSuggestions.isNotEmpty && _jobTitleController.text.isNotEmpty)
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
                      itemCount: filteredJobSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredJobSuggestions[index]),
                          onTap: () {
                            setState(() {
                              _jobTitleController.text = filteredJobSuggestions[index]; // Set the selected job
                              filteredJobSuggestions = []; // Clear the suggestions list
                              FocusScope.of(context).unfocus(); // Remove focus from the text field
                            });
                          },
                        );
                      },
                    ),
                  ),
                verticalSpace(20),
                CustomTextFormField(
                  hintText: 'Enter your GitHub profile URL',
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  labelText: 'GitHub Profile',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your GitHub profile URL';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  hintText: 'Enter your LinkedIn profile URL',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  labelText: 'LinkedIn Profile',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your LinkedIn profile URL';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  hintText: 'Enter your Profile Picture URL',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  labelText: 'Profile Picture',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your profile picture URL';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                // Row for language input and level dropdown
                Row(
                  children: [
                    // Text field for language
                    Expanded(
                      child: CustomTextFormField(
                        hintText: 'Enter a language',
                        keyboardType: TextInputType.text,
                        controller: _languageController,
                        labelText: 'Language',
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16), // Add spacing between text field and dropdown
                    // Dropdown for language level
                    DropdownButton<String>(
                      value: _selectedLanguageLevel,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguageLevel = newValue;
                        });
                      },
                      items: _languageLevels.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('Level'), // Placeholder text
                    ),
                  ],
                ),
                if (filteredLanguageSuggestions.isNotEmpty && _languageController.text.isNotEmpty)
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
                      itemCount: filteredLanguageSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredLanguageSuggestions[index]),
                          onTap: () {
                            setState(() {
                              _languageController.text = filteredLanguageSuggestions[index]; // Set the selected language
                              filteredLanguageSuggestions = []; // Clear the suggestions list
                              FocusScope.of(context).unfocus(); // Remove focus from the text field
                            });
                          },
                        );
                      },
                    ),
                  ),
                verticalSpace(10),
                // Button to add a new language
                ElevatedButton(
                  onPressed: _addLanguage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Set background color
                    foregroundColor: Colors.white, // Set text color
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Add padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Add rounded corners
                    ),
                  ),
                  child: Text(
                    'Add Language',
                    style: TextStyle(
                      fontSize: 16.sp, // Set font size
                      fontWeight: FontWeight.bold, // Set font weight
                    ),
                  ),
                ),
                verticalSpace(20),
                // Display added languages with a title
                if (_languages.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Languages',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      verticalSpace(10),
                      Column(
                        children: _languages.map((language) {
                          return ListTile(
                            title: Text('${language['language']} - ${language['level']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _removeLanguage(_languages.indexOf(language));
                              },
                            ),
                          );
                        }).toList(),
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
                      navKey.currentState!.pushReplacementNamed(RoutesName.education);
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