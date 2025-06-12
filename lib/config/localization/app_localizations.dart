import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @logInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue'**
  String get logInToContinue;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @registerHere.
  ///
  /// In en, this message translates to:
  /// **'Register here'**
  String get registerHere;

  /// No description provided for @registering.
  ///
  /// In en, this message translates to:
  /// **'Registering...'**
  String get registering;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get createAnAccount;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @logInHere.
  ///
  /// In en, this message translates to:
  /// **'Log in here'**
  String get logInHere;

  /// No description provided for @downloadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Downloaded Successfully'**
  String get downloadedSuccessfully;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpired;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to login'**
  String get goToLogin;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get welcome;

  /// No description provided for @welcomeB.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeB;

  /// No description provided for @welcomeToShortPath.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Short Path!'**
  String get welcomeToShortPath;

  /// No description provided for @whatWouldYouLikeToDoNext.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do next?'**
  String get whatWouldYouLikeToDoNext;

  /// No description provided for @fillInYourCV.
  ///
  /// In en, this message translates to:
  /// **'Fill in Your CV'**
  String get fillInYourCV;

  /// No description provided for @continueToHome.
  ///
  /// In en, this message translates to:
  /// **'Continue to Home'**
  String get continueToHome;

  /// No description provided for @youCanAlwaysUpdateYourCVLaterFromProfile.
  ///
  /// In en, this message translates to:
  /// **'You can always update your CV later from Profile.'**
  String get youCanAlwaysUpdateYourCVLaterFromProfile;

  /// No description provided for @permissionAlreadyGrantedDownloadingFile.
  ///
  /// In en, this message translates to:
  /// **'Permission already granted! Downloading file...'**
  String get permissionAlreadyGrantedDownloadingFile;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionRequired;

  /// No description provided for @doYouWantToGrantStoragePermissionToDownloadTheFile.
  ///
  /// In en, this message translates to:
  /// **'Do you want to grant storage permission to download the file?'**
  String get doYouWantToGrantStoragePermissionToDownloadTheFile;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @storagePermissionIsRequiredToDownloadTheFile.
  ///
  /// In en, this message translates to:
  /// **'Storage permission is required to download the file.'**
  String get storagePermissionIsRequiredToDownloadTheFile;

  /// No description provided for @permissionGrantedDownloadingFile.
  ///
  /// In en, this message translates to:
  /// **'Permission granted! Downloading file...'**
  String get permissionGrantedDownloadingFile;

  /// No description provided for @generateCv.
  ///
  /// In en, this message translates to:
  /// **'Generate CV'**
  String get generateCv;

  /// No description provided for @coverSheetB.
  ///
  /// In en, this message translates to:
  /// **'Cover Sheet'**
  String get coverSheetB;

  /// No description provided for @jobDescriptionTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Provide specific details about the job role for the best results!'**
  String get jobDescriptionTip;

  /// No description provided for @generatingCoverSheet.
  ///
  /// In en, this message translates to:
  /// **'Generating cover sheet...'**
  String get generatingCoverSheet;

  /// No description provided for @coverSheetReady.
  ///
  /// In en, this message translates to:
  /// **'Cover sheet ready!'**
  String get coverSheetReady;

  /// No description provided for @craftYourDreamCareer.
  ///
  /// In en, this message translates to:
  /// **'Craft Your Dream Career'**
  String get craftYourDreamCareer;

  /// No description provided for @enterAJobDescriptionToGenerateATailoredCVOrCoverSheetThatStandsOut.
  ///
  /// In en, this message translates to:
  /// **'Enter a job description to generate a tailored CV or cover sheet that stands out.'**
  String get enterAJobDescriptionToGenerateATailoredCVOrCoverSheetThatStandsOut;

  /// No description provided for @describeTheJobRole.
  ///
  /// In en, this message translates to:
  /// **'Describe the Job Role'**
  String get describeTheJobRole;

  /// No description provided for @egSoftwareEngineerAtATechStartup.
  ///
  /// In en, this message translates to:
  /// **'E.g., Software Engineer at a tech startup...'**
  String get egSoftwareEngineerAtATechStartup;

  /// No description provided for @chooseYourAction.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Action'**
  String get chooseYourAction;

  /// No description provided for @pleaseAddAJobDescription.
  ///
  /// In en, this message translates to:
  /// **'Please add a job description.'**
  String get pleaseAddAJobDescription;

  /// No description provided for @noCvFoundPromptingUserToCreateOne.
  ///
  /// In en, this message translates to:
  /// **'No CV found, prompting user to create one.'**
  String get noCvFoundPromptingUserToCreateOne;

  /// No description provided for @makeCv.
  ///
  /// In en, this message translates to:
  /// **'Make CV'**
  String get makeCv;

  /// No description provided for @pleaseMakeYourCv.
  ///
  /// In en, this message translates to:
  /// **'Please make your CV.'**
  String get pleaseMakeYourCv;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @haveCv.
  ///
  /// In en, this message translates to:
  /// **'Have CV?'**
  String get haveCv;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get copiedToClipboard;

  /// No description provided for @errorLoadingCv.
  ///
  /// In en, this message translates to:
  /// **'Error loading CV'**
  String get errorLoadingCv;

  /// No description provided for @noLanguagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No languages available.'**
  String get noLanguagesAvailable;

  /// No description provided for @noCvAvailable.
  ///
  /// In en, this message translates to:
  /// **'No CV available.'**
  String get noCvAvailable;

  /// No description provided for @yourCv.
  ///
  /// In en, this message translates to:
  /// **'Your CV'**
  String get yourCv;

  /// No description provided for @pleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later.'**
  String get pleaseTryAgainLater;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @internship.
  ///
  /// In en, this message translates to:
  /// **'Internship'**
  String get internship;

  /// No description provided for @noJobsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No jobs available.'**
  String get noJobsAvailable;

  /// No description provided for @pleaseCheckBackLater.
  ///
  /// In en, this message translates to:
  /// **'Please check back later.'**
  String get pleaseCheckBackLater;

  /// No description provided for @pleaseChooseAToolFromSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Please choose a tool from suggestions.'**
  String get pleaseChooseAToolFromSuggestions;

  /// No description provided for @toolAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'Tool {raw} already added.'**
  String toolAlreadyAdded(String raw);

  /// No description provided for @addYourEducation.
  ///
  /// In en, this message translates to:
  /// **'Add Your Education'**
  String get addYourEducation;

  /// No description provided for @enterYourInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Enter your institution name'**
  String get enterYourInstitutionName;

  /// No description provided for @institutionName.
  ///
  /// In en, this message translates to:
  /// **'Institution Name'**
  String get institutionName;

  /// No description provided for @pleaseEnterYourInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Institution name'**
  String get pleaseEnterYourInstitutionName;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @associates.
  ///
  /// In en, this message translates to:
  /// **'Associates'**
  String get associates;

  /// No description provided for @bachelors.
  ///
  /// In en, this message translates to:
  /// **'Bachelors'**
  String get bachelors;

  /// No description provided for @masters.
  ///
  /// In en, this message translates to:
  /// **'Masters'**
  String get masters;

  /// No description provided for @doctorate.
  ///
  /// In en, this message translates to:
  /// **'Doctorate'**
  String get doctorate;

  /// No description provided for @pleaseSelectYourDegree.
  ///
  /// In en, this message translates to:
  /// **'Please select your degree'**
  String get pleaseSelectYourDegree;

  /// No description provided for @enterYourFieldOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Enter your field of study'**
  String get enterYourFieldOfStudy;

  /// No description provided for @fieldOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Field of Study'**
  String get fieldOfStudy;

  /// No description provided for @pleaseEnterYourFieldOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Please enter your field of study'**
  String get pleaseEnterYourFieldOfStudy;

  /// No description provided for @enterYourInstitutionLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter your institution location'**
  String get enterYourInstitutionLocation;

  /// No description provided for @institutionLocation.
  ///
  /// In en, this message translates to:
  /// **'Institution Location'**
  String get institutionLocation;

  /// No description provided for @pleaseEnterYourInstitutionLocation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Institution Location'**
  String get pleaseEnterYourInstitutionLocation;

  /// No description provided for @graduationDate.
  ///
  /// In en, this message translates to:
  /// **'Graduation Date'**
  String get graduationDate;

  /// No description provided for @addingEducations.
  ///
  /// In en, this message translates to:
  /// **'Adding Educations...'**
  String get addingEducations;

  /// No description provided for @addingProfile.
  ///
  /// In en, this message translates to:
  /// **'Adding profile...'**
  String get addingProfile;

  /// No description provided for @enterYourLinkedInProfileUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter your LinkedIn profile URL'**
  String get enterYourLinkedInProfileUrl;

  /// No description provided for @linkedInProfile.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn Profile'**
  String get linkedInProfile;

  /// No description provided for @enterYourProfilePictureUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter your Profile Picture URL'**
  String get enterYourProfilePictureUrl;

  /// No description provided for @profilePicture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePicture;

  /// No description provided for @enterYourBioSummary.
  ///
  /// In en, this message translates to:
  /// **'Enter your bio/summary'**
  String get enterYourBioSummary;

  /// No description provided for @bioSummary.
  ///
  /// In en, this message translates to:
  /// **'Bio/Summary'**
  String get bioSummary;

  /// No description provided for @addingProjects.
  ///
  /// In en, this message translates to:
  /// **'Adding Projects...'**
  String get addingProjects;

  /// No description provided for @enterProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Title'**
  String get enterProjectTitle;

  /// No description provided for @projectTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Title'**
  String get projectTitle;

  /// No description provided for @freelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get freelance;

  /// No description provided for @yourSkills.
  ///
  /// In en, this message translates to:
  /// **'Your Skills'**
  String get yourSkills;

  /// No description provided for @addingSkills.
  ///
  /// In en, this message translates to:
  /// **'Adding Skills...'**
  String get addingSkills;

  /// No description provided for @addingWorkExperience.
  ///
  /// In en, this message translates to:
  /// **'Adding Work Experience...'**
  String get addingWorkExperience;

  /// No description provided for @yourSessionHasExpiredPleaseLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please login again.'**
  String get yourSessionHasExpiredPleaseLoginAgain;

  /// No description provided for @enterJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Job Title'**
  String get enterJobTitle;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @enterCompanyField.
  ///
  /// In en, this message translates to:
  /// **'Enter Company Field'**
  String get enterCompanyField;

  /// No description provided for @selectJobType.
  ///
  /// In en, this message translates to:
  /// **'Select Job Type'**
  String get selectJobType;

  /// No description provided for @jobLocation.
  ///
  /// In en, this message translates to:
  /// **'Job Location'**
  String get jobLocation;

  /// No description provided for @selectJobLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Job Location'**
  String get selectJobLocation;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @jobSummary.
  ///
  /// In en, this message translates to:
  /// **'Job Summary'**
  String get jobSummary;

  /// No description provided for @enterJobSummary.
  ///
  /// In en, this message translates to:
  /// **'Enter Job Summary'**
  String get enterJobSummary;

  /// No description provided for @enterCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Enter Company Name'**
  String get enterCompanyName;

  /// No description provided for @currentlyWorkingHere.
  ///
  /// In en, this message translates to:
  /// **'Currently working here'**
  String get currentlyWorkingHere;

  /// No description provided for @addWorkExperience.
  ///
  /// In en, this message translates to:
  /// **'Add Work Experience'**
  String get addWorkExperience;

  /// No description provided for @addedWorkExperience.
  ///
  /// In en, this message translates to:
  /// **'Added Work Experience:'**
  String get addedWorkExperience;

  /// No description provided for @enterYourPortfolioUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter your portfolio URL (GitHub, etc.)'**
  String get enterYourPortfolioUrl;

  /// No description provided for @pleaseChooseAnIndustrySkillFromTheSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Please choose an industry skill from the suggestions.'**
  String get pleaseChooseAnIndustrySkillFromTheSuggestions;

  /// No description provided for @industrySkillIsAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'Industry Skill {raw} is already added.'**
  String industrySkillIsAlreadyAdded(String raw);

  /// No description provided for @pleaseChooseASoftSkillFromTheSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Please choose a soft skill from the suggestions.'**
  String get pleaseChooseASoftSkillFromTheSuggestions;

  /// No description provided for @softSkillIsAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'Soft Skill {raw} is already added.'**
  String softSkillIsAlreadyAdded(String raw);

  /// No description provided for @pleaseChooseATechnicalSkillFromTheSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Please choose a technical skill from the suggestions.'**
  String get pleaseChooseATechnicalSkillFromTheSuggestions;

  /// No description provided for @technicalSkillIsAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'Technical Skill {raw} is already added.'**
  String technicalSkillIsAlreadyAdded(String raw);

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @fluent.
  ///
  /// In en, this message translates to:
  /// **'Fluent'**
  String get fluent;

  /// No description provided for @native.
  ///
  /// In en, this message translates to:
  /// **'Native'**
  String get native;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @findYourJob.
  ///
  /// In en, this message translates to:
  /// **'Find Your Job'**
  String get findYourJob;

  /// No description provided for @recentJobList.
  ///
  /// In en, this message translates to:
  /// **'Recent Job List'**
  String get recentJobList;

  /// No description provided for @joinTheShortPathCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join the Short Path CV Generator Community.'**
  String get joinTheShortPathCommunity;

  /// No description provided for @getStartedByJoiningShortPath.
  ///
  /// In en, this message translates to:
  /// **'Get started by joining Short Path CV Generator. Create an account or sign in to continue.'**
  String get getStartedByJoiningShortPath;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @career.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get career;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @enterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your Address'**
  String get enterYourAddress;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get back;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get register;

  /// No description provided for @additionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// No description provided for @addingAdditionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Adding additional info...'**
  String get addingAdditionalInfo;

  /// No description provided for @enterHobbiesAndInterests.
  ///
  /// In en, this message translates to:
  /// **'Enter Hobbies and Interests'**
  String get enterHobbiesAndInterests;

  /// No description provided for @hobbiesAndInterests.
  ///
  /// In en, this message translates to:
  /// **'Hobbies and Interests'**
  String get hobbiesAndInterests;

  /// No description provided for @enterPublications.
  ///
  /// In en, this message translates to:
  /// **'Enter Publications'**
  String get enterPublications;

  /// No description provided for @publications.
  ///
  /// In en, this message translates to:
  /// **'Publications'**
  String get publications;

  /// No description provided for @enterAwardsAndHonors.
  ///
  /// In en, this message translates to:
  /// **'Enter Awards and Honors'**
  String get enterAwardsAndHonors;

  /// No description provided for @awardsAndHonors.
  ///
  /// In en, this message translates to:
  /// **'Awards and Honors'**
  String get awardsAndHonors;

  /// No description provided for @enterVolunteerWorkDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter Volunteer Work Description'**
  String get enterVolunteerWorkDescription;

  /// No description provided for @volunteerWorkDescription.
  ///
  /// In en, this message translates to:
  /// **'Volunteer Work Description'**
  String get volunteerWorkDescription;

  /// No description provided for @noYears.
  ///
  /// In en, this message translates to:
  /// **'No. years'**
  String get noYears;

  /// No description provided for @noMonths.
  ///
  /// In en, this message translates to:
  /// **'No. months'**
  String get noMonths;

  /// No description provided for @addVolunteerWork.
  ///
  /// In en, this message translates to:
  /// **'Add volunteer work'**
  String get addVolunteerWork;

  /// No description provided for @certifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certifications;

  /// No description provided for @addingCertifications.
  ///
  /// In en, this message translates to:
  /// **'Adding Certifications...'**
  String get addingCertifications;

  /// No description provided for @enterCertificationName.
  ///
  /// In en, this message translates to:
  /// **'Enter Certification Name'**
  String get enterCertificationName;

  /// No description provided for @certificationName.
  ///
  /// In en, this message translates to:
  /// **'Certification Name'**
  String get certificationName;

  /// No description provided for @enterIssuingOrganization.
  ///
  /// In en, this message translates to:
  /// **'Enter Issuing Organization'**
  String get enterIssuingOrganization;

  /// No description provided for @issuingOrganization.
  ///
  /// In en, this message translates to:
  /// **'Issuing Organization'**
  String get issuingOrganization;

  /// No description provided for @dateEarned.
  ///
  /// In en, this message translates to:
  /// **'Date Earned'**
  String get dateEarned;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date'**
  String get expirationDate;

  /// No description provided for @addCertification.
  ///
  /// In en, this message translates to:
  /// **'Add Certification'**
  String get addCertification;

  /// No description provided for @educationProjects.
  ///
  /// In en, this message translates to:
  /// **'Education Projects'**
  String get educationProjects;

  /// No description provided for @enterProjectName.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Name'**
  String get enterProjectName;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// No description provided for @enterProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Description'**
  String get enterProjectDescription;

  /// No description provided for @projectDescription.
  ///
  /// In en, this message translates to:
  /// **'Project Description'**
  String get projectDescription;

  /// No description provided for @enterProjectLink.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Link'**
  String get enterProjectLink;

  /// No description provided for @projectLink.
  ///
  /// In en, this message translates to:
  /// **'Project Link'**
  String get projectLink;

  /// No description provided for @enterToolsTechnologiesUsed.
  ///
  /// In en, this message translates to:
  /// **'Enter Tools/Technologies Used'**
  String get enterToolsTechnologiesUsed;

  /// No description provided for @toolsTechnologiesUsed.
  ///
  /// In en, this message translates to:
  /// **'Tools/Technologies Used'**
  String get toolsTechnologiesUsed;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @addedProjects.
  ///
  /// In en, this message translates to:
  /// **'Added Projects:'**
  String get addedProjects;

  /// No description provided for @addNewEducation.
  ///
  /// In en, this message translates to:
  /// **'Add New Education'**
  String get addNewEducation;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @notProvided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @yrs.
  ///
  /// In en, this message translates to:
  /// **'Yrs'**
  String get yrs;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @workExperience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get workExperience;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @additionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional Info'**
  String get additionalInfo;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @jobType.
  ///
  /// In en, this message translates to:
  /// **'Job Type'**
  String get jobType;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @companyField.
  ///
  /// In en, this message translates to:
  /// **'Company Field'**
  String get companyField;

  /// No description provided for @noWorkExperienceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No work experience available.'**
  String get noWorkExperienceAvailable;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @noSkillsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No skills available.'**
  String get noSkillsAvailable;

  /// No description provided for @technicalSkills.
  ///
  /// In en, this message translates to:
  /// **'Technical Skills'**
  String get technicalSkills;

  /// No description provided for @softSkills.
  ///
  /// In en, this message translates to:
  /// **'Soft Skills'**
  String get softSkills;

  /// No description provided for @industrySpecificSkills.
  ///
  /// In en, this message translates to:
  /// **'Industry-Specific Skills'**
  String get industrySpecificSkills;

  /// No description provided for @technologies.
  ///
  /// In en, this message translates to:
  /// **'Technologies:'**
  String get technologies;

  /// No description provided for @noProjectsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No projects available.'**
  String get noProjectsAvailable;

  /// No description provided for @noProfileDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No profile data available.'**
  String get noProfileDataAvailable;

  /// No description provided for @linkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @fieldNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Field not specified'**
  String get fieldNotSpecified;

  /// No description provided for @locationNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Location not specified'**
  String get locationNotSpecified;

  /// No description provided for @graduation.
  ///
  /// In en, this message translates to:
  /// **'Graduation'**
  String get graduation;

  /// No description provided for @unknownDegree.
  ///
  /// In en, this message translates to:
  /// **'Unknown Degree'**
  String get unknownDegree;

  /// No description provided for @unknownInstitution.
  ///
  /// In en, this message translates to:
  /// **'Unknown Institution'**
  String get unknownInstitution;

  /// No description provided for @untitledProject.
  ///
  /// In en, this message translates to:
  /// **'Untitled Project'**
  String get untitledProject;

  /// No description provided for @noEducationDetailsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No education details available.'**
  String get noEducationDetailsAvailable;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @noExpiration.
  ///
  /// In en, this message translates to:
  /// **'No Expiration'**
  String get noExpiration;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @nA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get nA;

  /// No description provided for @noCertificationsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No certifications available.'**
  String get noCertificationsAvailable;

  /// No description provided for @hobbiesInterests.
  ///
  /// In en, this message translates to:
  /// **'Hobbies & Interests'**
  String get hobbiesInterests;

  /// No description provided for @volunteerWork.
  ///
  /// In en, this message translates to:
  /// **'Volunteer Work'**
  String get volunteerWork;

  /// No description provided for @noSkillsAddedYetStartByAddingSomeSkills.
  ///
  /// In en, this message translates to:
  /// **'No skills added yet. Start by adding some skills.'**
  String get noSkillsAddedYetStartByAddingSomeSkills;

  /// No description provided for @removedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Removed successfully!'**
  String get removedSuccessfully;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @addedBack.
  ///
  /// In en, this message translates to:
  /// **'Added back!'**
  String get addedBack;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @field.
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get field;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @dates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @skill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get skill;

  /// No description provided for @enterYourSkill.
  ///
  /// In en, this message translates to:
  /// **'Enter your skill'**
  String get enterYourSkill;

  /// No description provided for @proficiency.
  ///
  /// In en, this message translates to:
  /// **'Proficiency'**
  String get proficiency;

  /// No description provided for @selectProficiency.
  ///
  /// In en, this message translates to:
  /// **'Select proficiency'**
  String get selectProficiency;

  /// No description provided for @skillAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Skill added successfully'**
  String get skillAddedSuccessfully;

  /// No description provided for @soft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get soft;

  /// No description provided for @nothingAddedYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing added yet'**
  String get nothingAddedYet;

  /// No description provided for @addedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Added successfully'**
  String get addedSuccessfully;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @createYourCV.
  ///
  /// In en, this message translates to:
  /// **'Create Your CV'**
  String get createYourCV;

  /// No description provided for @fillInYourDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details'**
  String get fillInYourDetails;

  /// No description provided for @enterYourJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your job title'**
  String get enterYourJobTitle;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitle;

  /// No description provided for @enterALanguage.
  ///
  /// In en, this message translates to:
  /// **'Enter a language'**
  String get enterALanguage;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @enterYourPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Enter your portfolio URL (GitHub, etc.)'**
  String get enterYourPortfolio;

  /// No description provided for @invalidLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid link'**
  String get invalidLink;

  /// No description provided for @fillInYourEducationDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill in your education details'**
  String get fillInYourEducationDetails;

  /// No description provided for @addedCertifications.
  ///
  /// In en, this message translates to:
  /// **'Added Certifications:'**
  String get addedCertifications;

  /// No description provided for @issuedBy.
  ///
  /// In en, this message translates to:
  /// **'Issued by'**
  String get issuedBy;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @contractor.
  ///
  /// In en, this message translates to:
  /// **'Contractor'**
  String get contractor;

  /// No description provided for @fullTime.
  ///
  /// In en, this message translates to:
  /// **'Full Time'**
  String get fullTime;

  /// No description provided for @partTime.
  ///
  /// In en, this message translates to:
  /// **'Part Time'**
  String get partTime;

  /// No description provided for @transformToDes.
  ///
  /// In en, this message translates to:
  /// **'Transform Your Job Description\ninto a Professional CV!'**
  String get transformToDes;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful'**
  String get registrationSuccessful;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'APPLY NOW'**
  String get applyNow;

  /// No description provided for @employmentType.
  ///
  /// In en, this message translates to:
  /// **'Employment Type'**
  String get employmentType;

  /// No description provided for @salaryRange.
  ///
  /// In en, this message translates to:
  /// **'Salary Range'**
  String get salaryRange;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get readLess;

  /// No description provided for @jobDescription.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDescription;

  /// No description provided for @createCv.
  ///
  /// In en, this message translates to:
  /// **'CREATE CV'**
  String get createCv;

  /// No description provided for @coverSheet.
  ///
  /// In en, this message translates to:
  /// **'COVER SHEET'**
  String get coverSheet;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @contentFor.
  ///
  /// In en, this message translates to:
  /// **'Content for'**
  String get contentFor;

  /// No description provided for @trackYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Track Your Progress'**
  String get trackYourProgress;

  /// No description provided for @monitorYourJobSearchJourney.
  ///
  /// In en, this message translates to:
  /// **'Monitor your job search journey and stay updated on applications and interviews.'**
  String get monitorYourJobSearchJourney;

  /// No description provided for @smartRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendations'**
  String get smartRecommendations;

  /// No description provided for @getPersonalizedJobSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Get personalized job suggestions based on your experience and preferences.'**
  String get getPersonalizedJobSuggestions;

  /// No description provided for @aiPoweredJobSearch.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Job Search'**
  String get aiPoweredJobSearch;

  /// No description provided for @leverageAdvancedAI.
  ///
  /// In en, this message translates to:
  /// **'Leverage advanced AI to find the perfect job opportunities tailored to your skills.'**
  String get leverageAdvancedAI;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @noSavedJobsYet.
  ///
  /// In en, this message translates to:
  /// **'No saved jobs yet!'**
  String get noSavedJobsYet;

  /// No description provided for @yourSavedJobsWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your saved jobs will appear here.'**
  String get yourSavedJobsWillAppearHere;

  /// No description provided for @savedJobs.
  ///
  /// In en, this message translates to:
  /// **'Saved Jobs'**
  String get savedJobs;

  /// No description provided for @selectLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Level'**
  String get selectLevel;

  /// No description provided for @pleaseSelectALevel.
  ///
  /// In en, this message translates to:
  /// **'Please select a level.'**
  String get pleaseSelectALevel;

  /// No description provided for @languageAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Language added successfully'**
  String get languageAddedSuccessfully;

  /// No description provided for @degree.
  ///
  /// In en, this message translates to:
  /// **'Degree'**
  String get degree;

  /// No description provided for @selectDegree.
  ///
  /// In en, this message translates to:
  /// **'Select Degree'**
  String get selectDegree;

  /// No description provided for @contract.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get contract;

  /// No description provided for @remote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get remote;

  /// No description provided for @onsite.
  ///
  /// In en, this message translates to:
  /// **'Onsite'**
  String get onsite;

  /// No description provided for @hybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get hybrid;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
