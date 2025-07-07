import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('tr'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Zennect'**
  String get appName;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Please wait message
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get proceed;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get navClasses;

  /// No description provided for @navSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get navSchedule;

  /// No description provided for @navMembership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get navMembership;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @authLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLogin;

  /// No description provided for @authLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get authLogout;

  /// No description provided for @authRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegister;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPassword;

  /// No description provided for @authFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get authFirstName;

  /// No description provided for @authLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get authLastName;

  /// No description provided for @authPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get authPhone;

  /// No description provided for @authBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get authBirthDate;

  /// No description provided for @authGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get authGender;

  /// No description provided for @authMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authMale;

  /// No description provided for @authFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authFemale;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get authForgotPassword;

  /// No description provided for @authResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get authResetPassword;

  /// No description provided for @authNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get authNewPassword;

  /// No description provided for @authCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get authCurrentPassword;

  /// No description provided for @authRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get authRememberMe;

  /// No description provided for @authAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms and conditions'**
  String get authAgreeTerms;

  /// No description provided for @authAgreePrivacy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the privacy policy'**
  String get authAgreePrivacy;

  /// No description provided for @authAgreeKvkk.
  ///
  /// In en, this message translates to:
  /// **'I consent to the processing of my personal data under GDPR'**
  String get authAgreeKvkk;

  /// No description provided for @authCreateNewAccount.
  ///
  /// In en, this message translates to:
  /// **'New Account'**
  String get authCreateNewAccount;

  /// No description provided for @authSignInToAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignInToAccount;

  /// No description provided for @authDontHaveYouAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have you an account?'**
  String get authDontHaveYouAccount;

  /// No description provided for @authAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authAlreadyHaveAnAccount;

  /// No description provided for @authFillInBelowInformation.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the information below'**
  String get authFillInBelowInformation;

  /// No description provided for @authRememberYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get authRememberYourPassword;

  /// No description provided for @authResendMail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get authResendMail;

  /// No description provided for @authForgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'\'nter your email address and we will send you a link to reset your password.'**
  String get authForgotPasswordMessage;

  /// No description provided for @onboardingSplash.
  ///
  /// In en, this message translates to:
  /// **'Find Your Inner Balance'**
  String get onboardingSplash;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Zennect'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Get ready for new experiences in the world of Pilates, yoga and wellness'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Easy Booking'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Book and cancel your favorite classes with a single tap'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Personal Tracking'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Track your progress and reach your goals'**
  String get onboardingSubtitle3;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEdit;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get profilePersonalInfo;

  /// No description provided for @profileContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get profileContactInfo;

  /// No description provided for @profileMembershipInfo.
  ///
  /// In en, this message translates to:
  /// **'Membership Information'**
  String get profileMembershipInfo;

  /// No description provided for @profileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePassword;

  /// No description provided for @profileChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get profileChangePhoto;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @classesTitle.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get classesTitle;

  /// No description provided for @classesAll.
  ///
  /// In en, this message translates to:
  /// **'All Classes'**
  String get classesAll;

  /// No description provided for @classesPilates.
  ///
  /// In en, this message translates to:
  /// **'Pilates'**
  String get classesPilates;

  /// No description provided for @classesYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get classesYoga;

  /// No description provided for @classesMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get classesMeditation;

  /// No description provided for @classesWellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get classesWellness;

  /// No description provided for @classDetail.
  ///
  /// In en, this message translates to:
  /// **'Class Details'**
  String get classDetail;

  /// No description provided for @classBook.
  ///
  /// In en, this message translates to:
  /// **'Book Class'**
  String get classBook;

  /// No description provided for @classCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get classCancel;

  /// No description provided for @classJoinWaitlist.
  ///
  /// In en, this message translates to:
  /// **'Join Waitlist'**
  String get classJoinWaitlist;

  /// No description provided for @classLeaveWaitlist.
  ///
  /// In en, this message translates to:
  /// **'Leave Waitlist'**
  String get classLeaveWaitlist;

  /// No description provided for @classDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get classDuration;

  /// No description provided for @classCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get classCapacity;

  /// No description provided for @classInstructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get classInstructor;

  /// No description provided for @classStudio.
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get classStudio;

  /// No description provided for @classDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get classDifficulty;

  /// No description provided for @classDifficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get classDifficultyBeginner;

  /// No description provided for @classDifficultyIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get classDifficultyIntermediate;

  /// No description provided for @classDifficultyAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get classDifficultyAdvanced;

  /// No description provided for @classEquipment.
  ///
  /// In en, this message translates to:
  /// **'Required Equipment'**
  String get classEquipment;

  /// No description provided for @classDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get classDescription;

  /// No description provided for @classReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get classReviews;

  /// No description provided for @classAddReview.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get classAddReview;

  /// No description provided for @classFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get classFull;

  /// No description provided for @classAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get classAvailable;

  /// No description provided for @classFewSpots.
  ///
  /// In en, this message translates to:
  /// **'Few Spots Left'**
  String get classFewSpots;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @scheduleToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get scheduleToday;

  /// No description provided for @scheduleTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get scheduleTomorrow;

  /// No description provided for @scheduleThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get scheduleThisWeek;

  /// No description provided for @scheduleNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get scheduleNextWeek;

  /// No description provided for @scheduleFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get scheduleFilter;

  /// No description provided for @scheduleFilterInstructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get scheduleFilterInstructor;

  /// No description provided for @scheduleFilterStudio.
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get scheduleFilterStudio;

  /// No description provided for @scheduleFilterClassType.
  ///
  /// In en, this message translates to:
  /// **'Class Type'**
  String get scheduleFilterClassType;

  /// No description provided for @scheduleFilterDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty Level'**
  String get scheduleFilterDifficulty;

  /// No description provided for @scheduleMyReservations.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get scheduleMyReservations;

  /// No description provided for @schedulePastClasses.
  ///
  /// In en, this message translates to:
  /// **'Past Classes'**
  String get schedulePastClasses;

  /// No description provided for @scheduleUpcomingClasses.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Classes'**
  String get scheduleUpcomingClasses;

  /// No description provided for @reservationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get reservationsTitle;

  /// No description provided for @reservationsUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get reservationsUpcoming;

  /// No description provided for @reservationsPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get reservationsPast;

  /// No description provided for @reservationsCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get reservationsCancelled;

  /// No description provided for @reservationBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get reservationBook;

  /// No description provided for @reservationCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get reservationCancel;

  /// No description provided for @reservationCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this reservation?'**
  String get reservationCancelConfirm;

  /// No description provided for @reservationCancelled.
  ///
  /// In en, this message translates to:
  /// **'Reservation cancelled'**
  String get reservationCancelled;

  /// No description provided for @reservationBooked.
  ///
  /// In en, this message translates to:
  /// **'Reservation booked'**
  String get reservationBooked;

  /// No description provided for @reservationCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get reservationCheckIn;

  /// No description provided for @reservationCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get reservationCheckOut;

  /// No description provided for @reservationAttended.
  ///
  /// In en, this message translates to:
  /// **'Attended'**
  String get reservationAttended;

  /// No description provided for @reservationNotAttended.
  ///
  /// In en, this message translates to:
  /// **'Not Attended'**
  String get reservationNotAttended;

  /// No description provided for @reservationWaitlisted.
  ///
  /// In en, this message translates to:
  /// **'Waitlisted'**
  String get reservationWaitlisted;

  /// No description provided for @membershipTitle.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membershipTitle;

  /// No description provided for @membershipCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current Membership'**
  String get membershipCurrent;

  /// No description provided for @membershipPackages.
  ///
  /// In en, this message translates to:
  /// **'Membership Packages'**
  String get membershipPackages;

  /// No description provided for @membershipBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get membershipBuy;

  /// No description provided for @membershipRenew.
  ///
  /// In en, this message translates to:
  /// **'Renew'**
  String get membershipRenew;

  /// No description provided for @membershipUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get membershipUpgrade;

  /// No description provided for @membershipFreeze.
  ///
  /// In en, this message translates to:
  /// **'Freeze'**
  String get membershipFreeze;

  /// No description provided for @membershipActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get membershipActive;

  /// No description provided for @membershipExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get membershipExpired;

  /// No description provided for @membershipExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get membershipExpiringSoon;

  /// No description provided for @membershipSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get membershipSuspended;

  /// No description provided for @membershipStarts.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get membershipStarts;

  /// No description provided for @membershipEnds.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get membershipEnds;

  /// No description provided for @membershipRemainingClasses.
  ///
  /// In en, this message translates to:
  /// **'Remaining Classes'**
  String get membershipRemainingClasses;

  /// No description provided for @membershipUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get membershipUnlimited;

  /// No description provided for @membershipTypeTrial.
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get membershipTypeTrial;

  /// No description provided for @membershipTypeMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get membershipTypeMonthly;

  /// No description provided for @membershipTypeYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get membershipTypeYearly;

  /// No description provided for @membershipTypeClassPackage.
  ///
  /// In en, this message translates to:
  /// **'Class Package'**
  String get membershipTypeClassPackage;

  /// No description provided for @membershipHistory.
  ///
  /// In en, this message translates to:
  /// **'Membership History'**
  String get membershipHistory;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get paymentCreditCard;

  /// No description provided for @paymentBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentBankTransfer;

  /// No description provided for @paymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentCash;

  /// No description provided for @paymentCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get paymentCardNumber;

  /// No description provided for @paymentExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get paymentExpiryDate;

  /// No description provided for @paymentCvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get paymentCvv;

  /// No description provided for @paymentCardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get paymentCardholderName;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get paymentAmount;

  /// No description provided for @paymentTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get paymentTotal;

  /// No description provided for @paymentDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get paymentDiscount;

  /// No description provided for @paymentTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get paymentTax;

  /// No description provided for @paymentPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get paymentPayNow;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccess;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'Payment Pending'**
  String get paymentPending;

  /// No description provided for @paymentRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentRefunded;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No description provided for @instructorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Instructors'**
  String get instructorsTitle;

  /// No description provided for @instructorProfile.
  ///
  /// In en, this message translates to:
  /// **'Instructor Profile'**
  String get instructorProfile;

  /// No description provided for @instructorBio.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get instructorBio;

  /// No description provided for @instructorSpecialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get instructorSpecialties;

  /// No description provided for @instructorCertifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get instructorCertifications;

  /// No description provided for @instructorExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get instructorExperience;

  /// No description provided for @instructorClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get instructorClasses;

  /// No description provided for @instructorRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get instructorRating;

  /// No description provided for @instructorBookPrivate.
  ///
  /// In en, this message translates to:
  /// **'Book Private Session'**
  String get instructorBookPrivate;

  /// No description provided for @studiosTitle.
  ///
  /// In en, this message translates to:
  /// **'Studios'**
  String get studiosTitle;

  /// No description provided for @studioDetails.
  ///
  /// In en, this message translates to:
  /// **'Studio Details'**
  String get studioDetails;

  /// No description provided for @studioAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get studioAddress;

  /// No description provided for @studioPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get studioPhone;

  /// No description provided for @studioEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get studioEmail;

  /// No description provided for @studioEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get studioEquipment;

  /// No description provided for @studioCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get studioCapacity;

  /// No description provided for @studioAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get studioAmenities;

  /// No description provided for @studioDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get studioDirections;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsAll.
  ///
  /// In en, this message translates to:
  /// **'All Notifications'**
  String get notificationsAll;

  /// No description provided for @notificationsUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notificationsUnread;

  /// No description provided for @notificationsMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read'**
  String get notificationsMarkRead;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Notification'**
  String get notificationsDelete;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmpty;

  /// No description provided for @notificationClassReminder.
  ///
  /// In en, this message translates to:
  /// **'Class Reminder'**
  String get notificationClassReminder;

  /// No description provided for @notificationMembershipExpiring.
  ///
  /// In en, this message translates to:
  /// **'Membership Expiring'**
  String get notificationMembershipExpiring;

  /// No description provided for @notificationWaitlistAvailable.
  ///
  /// In en, this message translates to:
  /// **'Waitlist Spot Available'**
  String get notificationWaitlistAvailable;

  /// No description provided for @notificationAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get notificationAnnouncement;

  /// No description provided for @notificationClassCancelled.
  ///
  /// In en, this message translates to:
  /// **'Class Cancelled'**
  String get notificationClassCancelled;

  /// No description provided for @notificationPrivateClassApproved.
  ///
  /// In en, this message translates to:
  /// **'Private Class Approved'**
  String get notificationPrivateClassApproved;

  /// No description provided for @notificationPrivateClassRejected.
  ///
  /// In en, this message translates to:
  /// **'Private Class Rejected'**
  String get notificationPrivateClassRejected;

  /// No description provided for @notificationLowClassCount.
  ///
  /// In en, this message translates to:
  /// **'Low Class Count'**
  String get notificationLowClassCount;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get settingsAccount;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get settingsPrivacy;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get settingsPushNotifications;

  /// No description provided for @settingsClassReminders.
  ///
  /// In en, this message translates to:
  /// **'Class Reminders'**
  String get settingsClassReminders;

  /// No description provided for @settingsMembershipReminders.
  ///
  /// In en, this message translates to:
  /// **'Membership Reminders'**
  String get settingsMembershipReminders;

  /// No description provided for @settingsAnnouncementNotifications.
  ///
  /// In en, this message translates to:
  /// **'Announcement Notifications'**
  String get settingsAnnouncementNotifications;

  /// No description provided for @settingsReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get settingsReminderTime;

  /// No description provided for @settingsReminder15min.
  ///
  /// In en, this message translates to:
  /// **'15 minutes before'**
  String get settingsReminder15min;

  /// No description provided for @settingsReminder30min.
  ///
  /// In en, this message translates to:
  /// **'30 minutes before'**
  String get settingsReminder30min;

  /// No description provided for @settingsReminder1hour.
  ///
  /// In en, this message translates to:
  /// **'1 hour before'**
  String get settingsReminder1hour;

  /// No description provided for @settingsReminder2hours.
  ///
  /// In en, this message translates to:
  /// **'2 hours before'**
  String get settingsReminder2hours;

  /// No description provided for @settingsReminder1day.
  ///
  /// In en, this message translates to:
  /// **'1 day before'**
  String get settingsReminder1day;

  /// No description provided for @settingsBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get settingsBiometric;

  /// No description provided for @settingsAutoLogin.
  ///
  /// In en, this message translates to:
  /// **'Auto Login'**
  String get settingsAutoLogin;

  /// No description provided for @settingsLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// No description provided for @settingsLanguageEnShort.
  ///
  /// In en, this message translates to:
  /// **'tr'**
  String get settingsLanguageEnShort;

  /// No description provided for @settingsLanguageTr.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get settingsLanguageTr;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportTitle;

  /// No description provided for @supportFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get supportFaq;

  /// No description provided for @supportContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get supportContact;

  /// No description provided for @supportFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get supportFeedback;

  /// No description provided for @supportReportBug.
  ///
  /// In en, this message translates to:
  /// **'Report Bug'**
  String get supportReportBug;

  /// No description provided for @supportFeatureRequest.
  ///
  /// In en, this message translates to:
  /// **'Feature Request'**
  String get supportFeatureRequest;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get supportMessage;

  /// No description provided for @supportSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get supportSubject;

  /// No description provided for @supportSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get supportSendMessage;

  /// No description provided for @supportMessageSent.
  ///
  /// In en, this message translates to:
  /// **'Your message has been sent'**
  String get supportMessageSent;

  /// No description provided for @faqMembership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get faqMembership;

  /// No description provided for @faqClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get faqClasses;

  /// No description provided for @faqPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get faqPayments;

  /// No description provided for @faqTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get faqTechnical;

  /// No description provided for @faqGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get faqGeneral;

  /// No description provided for @announcementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcementsTitle;

  /// No description provided for @announcementNew.
  ///
  /// In en, this message translates to:
  /// **'New Announcement'**
  String get announcementNew;

  /// No description provided for @announcementImportant.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get announcementImportant;

  /// No description provided for @announcementGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get announcementGeneral;

  /// No description provided for @privateClassesTitle.
  ///
  /// In en, this message translates to:
  /// **'Private Classes'**
  String get privateClassesTitle;

  /// No description provided for @privateClassRequest.
  ///
  /// In en, this message translates to:
  /// **'Private Class Request'**
  String get privateClassRequest;

  /// No description provided for @privateClassInstructor.
  ///
  /// In en, this message translates to:
  /// **'Select Instructor'**
  String get privateClassInstructor;

  /// No description provided for @privateClassDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get privateClassDate;

  /// No description provided for @privateClassTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get privateClassTime;

  /// No description provided for @privateClassNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get privateClassNotes;

  /// No description provided for @privateClassPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get privateClassPrice;

  /// No description provided for @privateClassRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent'**
  String get privateClassRequestSent;

  /// No description provided for @privateClassApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get privateClassApproved;

  /// No description provided for @privateClassRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get privateClassRejected;

  /// No description provided for @privateClassPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get privateClassPending;

  /// No description provided for @privateClassCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get privateClassCompleted;

  /// No description provided for @privateClassCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get privateClassCancelled;

  /// No description provided for @userRoleMember.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get userRoleMember;

  /// No description provided for @userRoleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get userRoleTrainer;

  /// No description provided for @userRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get userRoleAdmin;

  /// No description provided for @userRoleSuperAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super Admin'**
  String get userRoleSuperAdmin;

  /// No description provided for @campaignsTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaigns'**
  String get campaignsTitle;

  /// No description provided for @campaignActive.
  ///
  /// In en, this message translates to:
  /// **'Active Campaigns'**
  String get campaignActive;

  /// No description provided for @campaignExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get campaignExpired;

  /// No description provided for @campaignDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get campaignDiscount;

  /// No description provided for @campaignPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get campaignPromoCode;

  /// No description provided for @campaignApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get campaignApply;

  /// No description provided for @campaignTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get campaignTerms;

  /// No description provided for @calendarToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calendarToday;

  /// No description provided for @calendarMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get calendarMonth;

  /// No description provided for @calendarWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get calendarWeek;

  /// No description provided for @calendarDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get calendarDay;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// No description provided for @monthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get monthApril;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get monthJune;

  /// No description provided for @monthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get monthDecember;

  /// No description provided for @timeMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get timeMorning;

  /// No description provided for @timeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get timeAfternoon;

  /// No description provided for @timeEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get timeEvening;

  /// No description provided for @timeNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get timeNight;

  /// No description provided for @timeNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get timeNow;

  /// No description provided for @timeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get timeToday;

  /// No description provided for @timeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get timeYesterday;

  /// No description provided for @timeTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get timeTomorrow;

  /// No description provided for @timeThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get timeThisWeek;

  /// No description provided for @timeNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get timeNextWeek;

  /// No description provided for @timeThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get timeThisMonth;

  /// No description provided for @timeNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next Month'**
  String get timeNextMonth;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again'**
  String get errorServer;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get errorTimeout;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please login again'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to perform this action'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested item was not found'**
  String get errorNotFound;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields correctly'**
  String get errorValidation;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get errorUnknown;

  /// No description provided for @errorClassFull.
  ///
  /// In en, this message translates to:
  /// **'Class is full. You can join the waitlist'**
  String get errorClassFull;

  /// No description provided for @errorMembershipExpired.
  ///
  /// In en, this message translates to:
  /// **'Your membership has expired'**
  String get errorMembershipExpired;

  /// No description provided for @errorInsufficientCredits.
  ///
  /// In en, this message translates to:
  /// **'Insufficient class credits'**
  String get errorInsufficientCredits;

  /// No description provided for @errorBookingTimePassed.
  ///
  /// In en, this message translates to:
  /// **'Booking time has passed'**
  String get errorBookingTimePassed;

  /// No description provided for @errorCancellationTimePassed.
  ///
  /// In en, this message translates to:
  /// **'Cancellation time has passed'**
  String get errorCancellationTimePassed;

  /// No description provided for @errorCheckYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please check your email'**
  String get errorCheckYourEmail;

  /// No description provided for @errorPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordsDoNotMatch;

  /// No description provided for @successLogin.
  ///
  /// In en, this message translates to:
  /// **'Successfully logged in'**
  String get successLogin;

  /// No description provided for @successLogout.
  ///
  /// In en, this message translates to:
  /// **'Successfully logged out'**
  String get successLogout;

  /// No description provided for @successRegister.
  ///
  /// In en, this message translates to:
  /// **'Registration completed'**
  String get successRegister;

  /// No description provided for @successPasswordReset.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent'**
  String get successPasswordReset;

  /// No description provided for @successPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password successfully changed'**
  String get successPasswordChanged;

  /// No description provided for @successProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get successProfileUpdated;

  /// No description provided for @successReservationBooked.
  ///
  /// In en, this message translates to:
  /// **'Reservation created'**
  String get successReservationBooked;

  /// No description provided for @successReservationCancelled.
  ///
  /// In en, this message translates to:
  /// **'Reservation cancelled'**
  String get successReservationCancelled;

  /// No description provided for @successPaymentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment completed successfully'**
  String get successPaymentCompleted;

  /// No description provided for @successMembershipPurchased.
  ///
  /// In en, this message translates to:
  /// **'Membership purchased'**
  String get successMembershipPurchased;

  /// No description provided for @successMessageSent.
  ///
  /// In en, this message translates to:
  /// **'Message sent'**
  String get successMessageSent;

  /// No description provided for @successFeedbackSent.
  ///
  /// In en, this message translates to:
  /// **'Feedback received'**
  String get successFeedbackSent;

  /// No description provided for @emptyClasses.
  ///
  /// In en, this message translates to:
  /// **'No classes yet'**
  String get emptyClasses;

  /// No description provided for @emptyReservations.
  ///
  /// In en, this message translates to:
  /// **'No reservations yet'**
  String get emptyReservations;

  /// No description provided for @emptyNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get emptyNotifications;

  /// No description provided for @emptyHistory.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get emptyHistory;

  /// No description provided for @emptySearch.
  ///
  /// In en, this message translates to:
  /// **'No search results found'**
  String get emptySearch;

  /// No description provided for @emptyInstructors.
  ///
  /// In en, this message translates to:
  /// **'No instructors yet'**
  String get emptyInstructors;

  /// No description provided for @emptyStudios.
  ///
  /// In en, this message translates to:
  /// **'No studios yet'**
  String get emptyStudios;

  /// No description provided for @loadingClasses.
  ///
  /// In en, this message translates to:
  /// **'Loading classes...'**
  String get loadingClasses;

  /// No description provided for @loadingSchedule.
  ///
  /// In en, this message translates to:
  /// **'Loading schedule...'**
  String get loadingSchedule;

  /// No description provided for @loadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get loadingProfile;

  /// No description provided for @loadingReservations.
  ///
  /// In en, this message translates to:
  /// **'Loading reservations...'**
  String get loadingReservations;

  /// No description provided for @loadingPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing payment...'**
  String get loadingPayment;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get confirmDeleteAccount;

  /// No description provided for @confirmCancelReservation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this reservation?'**
  String get confirmCancelReservation;

  /// No description provided for @confirmPurchase.
  ///
  /// In en, this message translates to:
  /// **'Do you confirm the purchase?'**
  String get confirmPurchase;

  /// No description provided for @classTypePilatesMat.
  ///
  /// In en, this message translates to:
  /// **'Mat Pilates'**
  String get classTypePilatesMat;

  /// No description provided for @classTypePilatesReformer.
  ///
  /// In en, this message translates to:
  /// **'Reformer Pilates'**
  String get classTypePilatesReformer;

  /// No description provided for @classTypePilatesChair.
  ///
  /// In en, this message translates to:
  /// **'Chair Pilates'**
  String get classTypePilatesChair;

  /// No description provided for @classTypePilatesCadillac.
  ///
  /// In en, this message translates to:
  /// **'Cadillac Pilates'**
  String get classTypePilatesCadillac;

  /// No description provided for @classTypePilatesBarrel.
  ///
  /// In en, this message translates to:
  /// **'Barrel Pilates'**
  String get classTypePilatesBarrel;

  /// No description provided for @classTypeHathaYoga.
  ///
  /// In en, this message translates to:
  /// **'Hatha Yoga'**
  String get classTypeHathaYoga;

  /// No description provided for @classTypeVinyasaYoga.
  ///
  /// In en, this message translates to:
  /// **'Vinyasa Yoga'**
  String get classTypeVinyasaYoga;

  /// No description provided for @classTypeAshtangaYoga.
  ///
  /// In en, this message translates to:
  /// **'Ashtanga Yoga'**
  String get classTypeAshtangaYoga;

  /// No description provided for @classTypeYinYoga.
  ///
  /// In en, this message translates to:
  /// **'Yin Yoga'**
  String get classTypeYinYoga;

  /// No description provided for @classTypeRestorative.
  ///
  /// In en, this message translates to:
  /// **'Restorative Yoga'**
  String get classTypeRestorative;

  /// No description provided for @classTypeHotYoga.
  ///
  /// In en, this message translates to:
  /// **'Hot Yoga'**
  String get classTypeHotYoga;

  /// No description provided for @classTypePowerYoga.
  ///
  /// In en, this message translates to:
  /// **'Power Yoga'**
  String get classTypePowerYoga;

  /// No description provided for @classTypeKundalini.
  ///
  /// In en, this message translates to:
  /// **'Kundalini Yoga'**
  String get classTypeKundalini;

  /// No description provided for @classTypeMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get classTypeMeditation;

  /// No description provided for @classTypeBreathwork.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get classTypeBreathwork;

  /// No description provided for @classTypeMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get classTypeMindfulness;

  /// No description provided for @classTypeWorkshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get classTypeWorkshop;

  /// No description provided for @classTypeRetreat.
  ///
  /// In en, this message translates to:
  /// **'Retreat'**
  String get classTypeRetreat;

  /// No description provided for @classTypePrivateSession.
  ///
  /// In en, this message translates to:
  /// **'Private Session'**
  String get classTypePrivateSession;

  /// No description provided for @studioTypePilates.
  ///
  /// In en, this message translates to:
  /// **'Pilates Studio'**
  String get studioTypePilates;

  /// No description provided for @studioTypeYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga Studio'**
  String get studioTypeYoga;

  /// No description provided for @studioTypeMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation Room'**
  String get studioTypeMeditation;

  /// No description provided for @studioTypeMultiPurpose.
  ///
  /// In en, this message translates to:
  /// **'Multi-Purpose'**
  String get studioTypeMultiPurpose;

  /// No description provided for @studioTypeOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get studioTypeOutdoor;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get aboutCompany;

  /// No description provided for @aboutContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get aboutContact;

  /// No description provided for @aboutTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get aboutTerms;

  /// No description provided for @aboutPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get aboutPrivacy;

  /// No description provided for @aboutLicenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get aboutLicenses;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @cookiePolicy.
  ///
  /// In en, this message translates to:
  /// **'Cookie Policy'**
  String get cookiePolicy;

  /// No description provided for @kvkkPolicy.
  ///
  /// In en, this message translates to:
  /// **'GDPR Information'**
  String get kvkkPolicy;

  /// Text showing number of classes
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 class} other{{count} classes}}'**
  String classesCountText(int count);

  /// Text showing number of spots remaining
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 spot left} other{{count} spots left}}'**
  String spotsRemainingText(int count);

  /// Duration in minutes
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// Price amount
  ///
  /// In en, this message translates to:
  /// **'\${amount}'**
  String priceAmount(double amount);

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeMessage(String name);

  /// Class booking confirmation message
  ///
  /// In en, this message translates to:
  /// **'You have successfully booked {className} on {date} at {time}'**
  String classBookedMessage(String className, DateTime date, DateTime time);
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
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
