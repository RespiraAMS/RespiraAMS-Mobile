// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonNoResults => 'No results found.';

  @override
  String get commonLoadMoreFailed => 'Couldn\'t load more. Tap to retry';

  @override
  String get commonLoadDataError => 'Couldn\'t load data';

  @override
  String get commonLoadInfoError => 'Couldn\'t load information';

  @override
  String get commonNoData => 'No data';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonDescription => 'Description';

  @override
  String get commonCode => 'Code';

  @override
  String get commonApply => 'Apply';

  @override
  String get commonClearFilters => 'Clear filters';

  @override
  String get commonAll => 'All';

  @override
  String get commonFilters => 'Filters';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonBack => 'Back';

  @override
  String get commonComingSoon => 'This feature is coming soon.';

  @override
  String commonTabComingSoon(String label) {
    return 'The \"$label\" tab will be added later.';
  }

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature is coming soon';
  }

  @override
  String get commonNotAvailable => 'Not available';

  @override
  String get commonNone => 'None';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonActive => 'Active';

  @override
  String commonVersion(String version) {
    return 'Version: $version';
  }

  @override
  String commonPoints(String score) {
    return '$score points';
  }

  @override
  String commonAddPoints(String score) {
    return '+ $score points';
  }

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonLoadFailedShort => 'Couldn\'t load data';

  @override
  String get navPatients => 'Patients';

  @override
  String get navLookup => 'Lookup';

  @override
  String get navDiagnosis => 'Diagnosis';

  @override
  String get navCalculators => 'Calculators';

  @override
  String get navStatistics => 'Statistics';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'Personalize your experience';

  @override
  String get settingsOpen => 'Open settings';

  @override
  String get settingsClose => 'Close settings';

  @override
  String get settingsProfileSpecialty => 'Respiratory Medicine';

  @override
  String get settingsDoctorFallback => 'Doctor';

  @override
  String get doctorProfileTitle => 'Doctor profile';

  @override
  String get doctorProfileSubtitle => 'Account details';

  @override
  String get doctorProfileOpen => 'Open doctor profile';

  @override
  String get doctorProfileSectionProfessional => 'Professional';

  @override
  String get doctorProfileSectionContact => 'Contact';

  @override
  String get doctorProfileSectionPersonal => 'Personal';

  @override
  String get doctorProfileAcademicTitle => 'Academic title';

  @override
  String get doctorProfileDegrees => 'Degrees';

  @override
  String get doctorProfilePosition => 'Position';

  @override
  String get doctorProfileRole => 'Role';

  @override
  String get doctorProfileEmail => 'Email';

  @override
  String get doctorProfilePhone => 'Phone';

  @override
  String get doctorProfileAddress => 'Address';

  @override
  String get doctorProfileGender => 'Gender';

  @override
  String get doctorProfileCitizenId => 'Citizen ID';

  @override
  String get doctorProfileRoleDoctor => 'Doctor';

  @override
  String get doctorProfileRoleAdmin => 'Administrator';

  @override
  String get doctorProfileGenderOther => 'Other';

  @override
  String get doctorProfileError => 'Couldn\'t load the doctor profile.';

  @override
  String get doctorProfileEmpty => 'No profile details available.';

  @override
  String get doctorProfileRetry => 'Try again';

  @override
  String get doctorProfileEdit => 'Edit profile';

  @override
  String get doctorProfileEditTitle => 'Edit profile';

  @override
  String get doctorProfileEditSubtitle => 'Update your doctor information';

  @override
  String get doctorProfileAvatarChange => 'Change photo';

  @override
  String get doctorProfileAvatarHint => 'JPG, PNG or WEBP · up to 5 MB';

  @override
  String get doctorProfileAvatarTooLarge =>
      'The photo must be smaller than 5 MB.';

  @override
  String get doctorProfileAvatarInvalid =>
      'Only JPG, PNG or WEBP images are supported.';

  @override
  String get doctorProfileSectionSecurity => 'Security';

  @override
  String get doctorProfileDob => 'Date of birth';

  @override
  String get doctorProfileEmailHint => 'This email is used to sign in.';

  @override
  String get doctorProfileNewPassword => 'New password';

  @override
  String get doctorProfileConfirmPassword => 'Confirm password';

  @override
  String get doctorProfilePasswordHint =>
      'Leave blank to keep the current password.';

  @override
  String get doctorProfilePasswordMismatch => 'The passwords do not match.';

  @override
  String get doctorProfilePasswordWeak =>
      'Use at least 8 characters with an uppercase letter and a number or symbol.';

  @override
  String get doctorProfileErrEmail => 'Invalid email address.';

  @override
  String get doctorProfileErrRequired => 'Please fill in all required fields.';

  @override
  String get doctorProfileSave => 'Save changes';

  @override
  String get doctorProfileSaving => 'Saving…';

  @override
  String get doctorProfileSaveSuccess => 'Doctor profile updated.';

  @override
  String get doctorProfileSaveFailed => 'Unable to update the doctor profile.';

  @override
  String get doctorProfileSaveForbidden =>
      'You are not allowed to update this profile.';

  @override
  String get doctorProfileSaveTimeout => 'The profile update timed out.';

  @override
  String get doctorDegreeProfessor => 'Professor';

  @override
  String get doctorDegreeDoctor => 'Doctor';

  @override
  String get doctorDegreeMaster => 'Master';

  @override
  String get doctorDegreeBachelor => 'Bachelor';

  @override
  String get doctorDegreeAssociate => 'Associate';

  @override
  String get doctorDegreeUndergraduate => 'Undergraduate';

  @override
  String get doctorDegreeGraduate => 'Graduate';

  @override
  String get doctorDegreePhd => 'PhD';

  @override
  String get doctorDegreePostDoc => 'Post-doctorate';

  @override
  String get doctorTitleNone => 'None';

  @override
  String get doctorTitleAssociateProfessor => 'Associate professor';

  @override
  String get doctorTitleProfessor => 'Professor';

  @override
  String get doctorPositionStaff => 'Staff doctor';

  @override
  String get doctorPositionSenior => 'Senior doctor';

  @override
  String get doctorPositionDeputyHead => 'Department deputy head';

  @override
  String get doctorPositionHead => 'Head of department';

  @override
  String get doctorPositionDeputyDirector => 'Deputy director';

  @override
  String get doctorPositionDirector => 'Director';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSubtitle => 'Light or dark';

  @override
  String get settingsThemeSheetTitle => 'Display mode';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsFontSize => 'Text size';

  @override
  String get settingsTextSmall => 'Small';

  @override
  String get settingsTextStandard => 'Default';

  @override
  String get settingsTextLarge => 'Large';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageVietnamese => 'Tiếng Việt';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLogout => 'Sign out';

  @override
  String get settingsLogoutConfirmTitle => 'Sign out?';

  @override
  String get settingsLogoutConfirmBody =>
      'You\'ll need to sign in again to keep using RespiraAMS.';

  @override
  String get splashSubtitle => 'Clinical workspace for respiratory care';

  @override
  String get authLoginTitle => 'Sign in';

  @override
  String get authLoginSubtitle => 'Continue to your RespiraAMS workspace.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authLoginButton => 'Sign in';

  @override
  String get authSecureSessionTitle => 'Secure session';

  @override
  String get authSecureSessionBody =>
      'Locks automatically when idle and is protected by role.';

  @override
  String get authSupportFooter =>
      'Need help? Contact your hospital administrator.';

  @override
  String get authMissingCredentials => 'Enter your email and password.';

  @override
  String get authEmailInvalid => 'That email address is not valid.';

  @override
  String get authServerUnreachable =>
      'Couldn\'t reach the server. Please try again.';

  @override
  String get authForgotTitle => 'Forgot password?';

  @override
  String get authForgotBody =>
      'Enter your work email. We\'ll send a 6-digit verification code.';

  @override
  String get authWorkEmailLabel => 'Work email';

  @override
  String get authSendCode => 'Send verification code';

  @override
  String get authBackToLogin => 'Back to sign in';

  @override
  String get authNoEmailTitle => 'Didn\'t get the email?';

  @override
  String get authNoEmailBody =>
      'Check your spam folder or contact your administrator to verify your account.';

  @override
  String get authOtpTitle => 'Enter verification code';

  @override
  String authOtpSentTo(String email) {
    return 'A 6-digit code was sent to $email';
  }

  @override
  String get authResend => 'Resend code';

  @override
  String authResendIn(String seconds) {
    return 'Resend code in 00:$seconds';
  }

  @override
  String get authConfirm => 'Confirm';

  @override
  String get authAccountSecurityTitle => 'Account security';

  @override
  String get authAccountSecurityBody =>
      'Never share your verification code. It expires after 10 minutes and can only be used once.';

  @override
  String get authChangeEmail => 'Change email';

  @override
  String get authStepIdentity => 'Step 1/2 · Verify your identity';

  @override
  String get authNewPasswordTitle => 'Create a new password';

  @override
  String get authNewPasswordBody =>
      'Choose a strong password to protect patient data and your session.';

  @override
  String get authNewPasswordLabel => 'New password';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authPasswordRequirements => 'Your password needs';

  @override
  String get authMinLength => 'At least 8 characters';

  @override
  String get authUppercase => 'At least 1 uppercase letter';

  @override
  String get authDigitOrSpecial => 'At least 1 number or special character';

  @override
  String get authPasswordMismatch => 'Passwords don\'t match.';

  @override
  String get authUpdatePassword => 'Update password';

  @override
  String get authCancelBack => 'Cancel and go back';

  @override
  String get authStepPassword => 'Step 2/2 · Set your password';

  @override
  String get authResetSuccessTitle => 'Password updated';

  @override
  String get authResetSuccessBody =>
      'You can sign in again and continue working in RespiraAMS.';

  @override
  String get authDemoDoctorName => 'Dr. Le Hoang Minh';

  @override
  String get authDoctorRoleVerified =>
      'Respiratory Medicine · Verified account';

  @override
  String get authWorkspaceReady => 'Your workspace is ready';

  @override
  String get authRestoreAccess =>
      'Your data and access will be restored after signing in.';

  @override
  String get authLoginNow => 'Sign in now';

  @override
  String get authBackToWelcome => 'Back to welcome';

  @override
  String get authWorkspaceEyebrow => 'MOBILE CLINICAL WORKSPACE';

  @override
  String authWelcomeGreeting(String name) {
    return 'Welcome, $name';
  }

  @override
  String get authWelcomeSubtitle =>
      'Ready to review today\'s respiratory cases.';

  @override
  String authWelcomeBulletPatients(String count) {
    return '$count patients under monitoring';
  }

  @override
  String authWelcomeBulletAttention(String count) {
    return '$count cases under treatment today';
  }

  @override
  String authWelcomeBulletSynced(String time) {
    return 'Data synced at $time';
  }

  @override
  String get authStart => 'Get started';

  @override
  String get authPrivacyFooter =>
      'Medical data is protected by system-level access control.';

  @override
  String get commonTryAgain => 'Try again';

  @override
  String get commonEnterNumber => 'Enter a number';

  @override
  String get commonServerUnreachable =>
      'Unable to reach the server. Please check your network connection.';

  @override
  String commonBadRequest(int status) {
    return 'Invalid request (code $status).';
  }

  @override
  String commonLoadErrorWith(String error) {
    return 'Unable to load data: $error';
  }

  @override
  String commonLoadInfoErrorWith(String error) {
    return 'Unable to load information: $error';
  }

  @override
  String get commonOther => 'Other';

  @override
  String get commonYesNo => 'Yes / No';

  @override
  String get commonMlPerMin => 'mL/min';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get patientStatusTreating => 'Under treatment';

  @override
  String get patientStatusRecovered => 'Recovered';

  @override
  String get patientStatusDeceased => 'Deceased';

  @override
  String get patientStatusOutOfScope => 'Out of treatment scope';

  @override
  String patientAge(int age) {
    return '$age years old';
  }

  @override
  String get patientListTitle => 'Patients';

  @override
  String patientFollowingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count patients under monitoring',
      one: '1 patient under monitoring',
    );
    return '$_temp0';
  }

  @override
  String get patientFilterAll => 'All';

  @override
  String get patientFilterAttention => 'Needs attention';

  @override
  String get patientFilterHighRisk => 'High risk';

  @override
  String patientCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count patients',
      one: '1 patient',
    );
    return '$_temp0';
  }

  @override
  String get patientPrioritySort => 'Priority';

  @override
  String get patientSearchHint => 'Search by name or medical record code';

  @override
  String get patientAddSemantic => 'Add patient';

  @override
  String get patientEmpty => 'No matching patients found.';

  @override
  String get patientDetailTitle => 'Patient details';

  @override
  String get patientDetailSubtitle =>
      'Read-only information and treatment progress';

  @override
  String get patientProfileError => 'Unable to load the patient record.';

  @override
  String get patientNoSelection => 'No patient selected.';

  @override
  String get patientRecordSection => 'Record information';

  @override
  String get patientDobGender => 'Date of birth · Gender';

  @override
  String get patientInsurance => 'Insurance';

  @override
  String get patientAddress => 'Address';

  @override
  String get patientVitals => 'Vitals';

  @override
  String get patientTreatmentStatus => 'Treatment status';

  @override
  String get patientProgressSection => 'Treatment progress';

  @override
  String get patientNoProgress => 'No treatment progress yet.';

  @override
  String get patientAddTreatment => 'Add treatment';

  @override
  String get patientUpdateStatus => 'Update status';

  @override
  String patientEpisode(int index) {
    return 'Episode $index';
  }

  @override
  String get patientSavedTreatment => 'Saved treatment';

  @override
  String get treatmentPlanInProgress => 'In progress';

  @override
  String get treatmentPlanClosed => 'Closed';

  @override
  String get adherenceAdhere => 'Adheres to protocol';

  @override
  String get adherenceNotAdhere => 'Not adhered';

  @override
  String get adherenceNotAdhereValid => 'Not adhered (acceptable)';

  @override
  String get adherenceNotAdhereInvalid => 'Not adhered (invalid)';

  @override
  String get patientAddTitle => 'Add patient';

  @override
  String get patientAddSubtitle => 'Create a new patient record';

  @override
  String get patientLastName => 'Last name';

  @override
  String get patientFirstName => 'First name';

  @override
  String get patientRecordCode => 'Medical record code';

  @override
  String get patientRecordCodeHint => 'e.g. BA-2026-0001';

  @override
  String get patientDob => 'Date of birth';

  @override
  String get patientInsuranceCard => 'Insurance card number';

  @override
  String get patientPhone => 'Phone number';

  @override
  String get patientHeight => 'Height';

  @override
  String get patientWeight => 'Weight';

  @override
  String get patientProvince => 'Province/City';

  @override
  String get patientGender => 'Gender';

  @override
  String get patientSaving => 'Saving…';

  @override
  String get patientSaveRecord => 'Save record';

  @override
  String get patientErrName => 'Please enter the full name.';

  @override
  String get patientErrCode => 'Please enter the medical record code.';

  @override
  String get patientErrDob => 'Please enter the date of birth.';

  @override
  String get patientErrDobFormat => 'Invalid date of birth (dd/MM/yyyy).';

  @override
  String get patientErrPhone => 'Invalid phone number.';

  @override
  String get patientErrInsurance =>
      'The insurance card number must have 10 digits.';

  @override
  String get patientErrHeight => 'Height must be greater than 0.';

  @override
  String get patientErrWeight => 'Weight must be greater than 0.';

  @override
  String get patientErrAddress => 'Please enter the address.';

  @override
  String get patientErrCity => 'Please enter the province/city.';

  @override
  String get patientCreateFailed =>
      'Unable to create the patient. Please try again.';

  @override
  String get patientMenuSemantic => 'Patient options';

  @override
  String get patientMenuEdit => 'Edit';

  @override
  String get patientMenuDelete => 'Delete';

  @override
  String get patientEditTitle => 'Edit patient';

  @override
  String get patientEditSubtitle => 'Update demographic & clinical information';

  @override
  String get patientEditCancel => 'Cancel';

  @override
  String get patientEditSave => 'Save changes';

  @override
  String get patientEditSuccess => 'Patient updated.';

  @override
  String get patientEditFailed => 'Unable to update the patient.';

  @override
  String get patientEditLoadFailed => 'Unable to load the patient profile.';

  @override
  String get patientEditClinicalLocked =>
      'Date of birth, gender, weight and height cannot be changed once the patient has a treatment.';

  @override
  String get patientFullName => 'Full name';

  @override
  String get patientSectionAdmin => 'Administrative information';

  @override
  String get patientSectionVitals => 'Vitals';

  @override
  String get patientRequiredHint => 'Required (*)';

  @override
  String get patientDeleteTitle => 'Delete patient';

  @override
  String get patientDeleteDescription =>
      'The patient record will be permanently deleted. This action cannot be undone.';

  @override
  String get patientDeleteConfirm => 'Delete';

  @override
  String get patientDeleteSuccess => 'Patient deleted.';

  @override
  String get patientDeleteFailed => 'Unable to delete the patient.';

  @override
  String get patientDischarge => 'Discharge';

  @override
  String get patientDischargeTitle => 'Discharge patient';

  @override
  String get patientDischargeAdmission => 'Admission date';

  @override
  String get patientDischargeOutcomeLabel => 'TREATMENT OUTCOME *';

  @override
  String get patientDischargeRecovered => 'Recovered';

  @override
  String get patientDischargeRecoveredDesc =>
      'Symptoms improved, eligible for discharge';

  @override
  String get patientDischargeDeath => 'Death';

  @override
  String get patientDischargeDeathDesc =>
      'Death recorded during inpatient treatment';

  @override
  String get patientDischargeOutOfScope => 'Out of scope';

  @override
  String get patientDischargeOutOfScopeDesc =>
      'Transferred to a higher-level facility or taken home by family';

  @override
  String patientDischargeSelected(String outcome) {
    return 'Selected outcome: $outcome. Ready to save to the medical record.';
  }

  @override
  String get patientDischargeConfirm => 'Confirm discharge';

  @override
  String get patientDischargeCancel => 'Cancel';

  @override
  String get patientDischargeSuccess => 'Patient discharged.';

  @override
  String get patientDischargeFailed => 'Unable to discharge. Please try again.';

  @override
  String get patientDischargedBanner => 'Patient has been discharged';

  @override
  String patientDischargedAt(String date, String outcome) {
    return '$date · $outcome';
  }

  @override
  String get progressTitle => 'Add progress';

  @override
  String get progressSubtitleTargeted =>
      'Based on the existing microbiology result';

  @override
  String get progressSubtitleEmpirical => 'Record the latest treatment change';

  @override
  String get progressTreatmentTypeNext => 'Next treatment type';

  @override
  String get progressTreatmentType => 'Treatment type';

  @override
  String get progressContinueTargeted => 'Continue targeted therapy';

  @override
  String get progressSave => 'Save progress';

  @override
  String get progressReason => 'Reason for change';

  @override
  String get progressHasMicro => 'Microbiology result available';

  @override
  String get progressHasMicroDesc =>
      'Switch to targeted therapy when appropriate.';

  @override
  String get progressPoorResponse => 'Poor response';

  @override
  String get progressPoorResponseDesc =>
      'Symptoms did not improve during follow-up.';

  @override
  String get progressLockTitle => 'Cannot be edited after saving';

  @override
  String get progressLockDesc =>
      'Create a new progress entry if another update is needed.';

  @override
  String get progressTargetedAlertTitle =>
      'Targeted therapy based on the microbiology result';

  @override
  String get progressTargetedAlertDesc =>
      'Check the pathogen and antibiogram before choosing drugs.';

  @override
  String get treatmentEmpirical => 'Empirical';

  @override
  String get treatmentTargeted => 'Targeted therapy';

  @override
  String get diagnosisTitle => 'Empirical diagnosis';

  @override
  String diagnosisStepProgress(int step, int total, String title) {
    return 'Step $step of $total · $title';
  }

  @override
  String get diagnosisBack => 'Back';

  @override
  String get diagnosisContinue => 'Continue';

  @override
  String get diagnosisRun => 'Diagnose';

  @override
  String get diagnosisPersonalInfo => 'Personal information';

  @override
  String get diagnosisVitalSigns => 'Vital signs';

  @override
  String get diagnosisLabResults => 'Laboratory results';

  @override
  String get diagnosisComorbidities => 'Comorbidities & risk';

  @override
  String get diagnosisAllergy => 'Allergy';

  @override
  String get diagnosisAllergyType => 'Antibiotic allergy status';

  @override
  String get diagnosisAllergyNo => 'No allergy';

  @override
  String get diagnosisAllergyYes => 'Antibiotic allergy';

  @override
  String get diagnosisAllergyNonRegistered =>
      'Allergy to an unlisted antibiotic';

  @override
  String get diagnosisAllergyUnknown => 'Unknown / other allergy';

  @override
  String get diagnosisAllergySelect => 'Select the allergenic antibiotics';

  @override
  String get diagnosisAllergyOther => 'Describe the other allergy';

  @override
  String get diagnosisAllergyOtherHint =>
      'e.g. amoxicillin rash, unknown beta-lactam reaction';

  @override
  String get diagnosisEmptyForm => 'No form data.';

  @override
  String get diagnosisFormLoadFailed => 'Unable to load the diagnosis form.';

  @override
  String get diagnosisResultTitle => 'Diagnosis result';

  @override
  String get diagnosisResultSubtitle =>
      'Empirical · Community-acquired pneumonia';

  @override
  String get diagnosisSaveResult => 'Save result';

  @override
  String get diagnosisTabResult => 'Result';

  @override
  String get diagnosisTabSuspected => 'Etiology';

  @override
  String get diagnosisTabEvidences => 'Evidence';

  @override
  String get diagnosisSectionDiagnosis => 'Diagnosis';

  @override
  String get diagnosisCommunityPneumonia => 'Community-acquired pneumonia';

  @override
  String get diagnosisEmpiricalLabel => 'Empirical diagnosis';

  @override
  String get diagnosisSectionAssessment => 'Assessment';

  @override
  String get diagnosisSeverity => 'Severity';

  @override
  String get diagnosisTreatment => 'Treatment';

  @override
  String get diagnosisConfirmNote =>
      'Results must be confirmed by a physician before treatment is applied.';

  @override
  String get suspectedHeavy => 'Highly suspected etiology';

  @override
  String get suspectedWorth => 'Etiology to note';

  @override
  String get evidenceSection => 'Clinical evidence';

  @override
  String get diagnosisNoData => 'No data.';

  @override
  String evidencePoints(int score) {
    return 'Score $score';
  }

  @override
  String get evidenceMajor => 'Major';

  @override
  String get evidenceMinor => 'Minor';

  @override
  String get severityMild => 'Mild';

  @override
  String get severityModerate => 'Moderate';

  @override
  String get severitySevere => 'Severe';

  @override
  String get siteInpatient => 'Inpatient';

  @override
  String get siteOutpatient => 'Outpatient';

  @override
  String get siteIcu => 'ICU';

  @override
  String get riskHigh => 'High risk';

  @override
  String get riskLow => 'Low risk';

  @override
  String get riskWatch => 'Monitor';

  @override
  String get alertPregnantTitle => 'Patient is pregnant / breastfeeding';

  @override
  String get alertPregnantDesc =>
      'Consider carefully before prescribing antibiotics.';

  @override
  String get alertMissingTitle => 'Missing required information';

  @override
  String get targetedTitle => 'Microbiology diagnosis';

  @override
  String get targetedSubtitle => 'Each route is a separate drug option';

  @override
  String get targetedLoadError =>
      'Unable to load recommendations. Please try again.';

  @override
  String get targetedSelectDrugs => 'Select drug + route';

  @override
  String get targetedSelectedSummary => 'Selected by drug + route';

  @override
  String get targetedSave => 'Save targeted therapy';

  @override
  String get microBacteria => 'Bacteria';

  @override
  String get microLatestAntibiogram => 'Latest antibiogram';

  @override
  String get diagnosisFlowNoPatient => 'No patient selected.';

  @override
  String get diagnosisFlowFormError => 'Unable to load the diagnosis form.';

  @override
  String diagnosisFlowMissing(String fields) {
    return 'Missing required information: $fields.';
  }

  @override
  String get diagnosisMedicalHistory => 'Medical history';

  @override
  String get diagnosisAssessment => 'Severity & infection assessment';

  @override
  String get diagnosisClinical => 'Clinical';

  @override
  String get diagnosisParaclinical => 'Paraclinical';

  @override
  String get diagnosisVariableSearch => 'Search variables';

  @override
  String get diagnosisVariableSearchHint =>
      'Filter by name, code or description…';

  @override
  String get diagnosisAntibioticSearch => 'Search antibiotics';

  @override
  String get diagnosisAntibioticSearchHint =>
      'Type to filter by name or group…';

  @override
  String diagnosisNormalRangeBoth(String min, String max) {
    return 'normal: $min-$max';
  }

  @override
  String diagnosisNormalRangeMin(String min) {
    return 'normal: ≥ $min';
  }

  @override
  String diagnosisNormalRangeMax(String max) {
    return 'normal: ≤ $max';
  }

  @override
  String get diagnosisSpecialHistory => 'Special medical history';

  @override
  String get diagnosisSpecialHistoryHint =>
      'e.g. prior pulmonary tuberculosis, recent chemotherapy';

  @override
  String get diagnosisAdd => 'Add';

  @override
  String get diagnosisRemove => 'Remove';

  @override
  String get diagnosisOtherInfections => 'Other infections';

  @override
  String get diagnosisOtherInfectionsSelect => 'Select concurrent infections';

  @override
  String get diagnosisMicrobialSamples => 'Microbiology samples';

  @override
  String get diagnosisMicrobialAdd => 'Add sample';

  @override
  String get diagnosisMicrobialSampleType => 'Sample type';

  @override
  String get diagnosisMicrobialMicCategory => 'MIC category';

  @override
  String get diagnosisMicrobialPathogen => 'Pathogen';

  @override
  String get diagnosisMicrobialPathogenHint => 'Select pathogen';

  @override
  String get diagnosisMicrobialPathogenRequired =>
      'Please select a pathogen for every microbiology sample.';

  @override
  String get diagnosisAllergyRequired =>
      'Please select the antibiotic allergy status.';

  @override
  String get diagnosisAllergyYesRequired =>
      'Please select at least one allergenic antibiotic.';

  @override
  String get diagnosisAllergyOtherRequired =>
      'Please describe the other allergy.';

  @override
  String diagnosisInvalidNumber(String name) {
    return '\"$name\" must be a number.';
  }

  @override
  String diagnosisInvalidFields(String fields) {
    return 'Invalid data in: $fields. Please review the values.';
  }

  @override
  String diagnosisRangeWarning(String range) {
    return 'Outside the suggested range $range. You can still continue.';
  }

  @override
  String get diagnosisEgfr => 'eGFR';

  @override
  String get diagnosisOtherInfectionsTitle => 'Other infections';

  @override
  String get diagnosisAllergyTitle => 'Antibiotic allergy';

  @override
  String get diagnosisAllergyNoValue => 'None';

  @override
  String get diagnosisSectionMetrics => 'Score details';

  @override
  String diagnosisMetricsMajorMinor(int major, int minor) {
    return 'Major $major · Minor $minor';
  }

  @override
  String get diagnosisTabProtocols => 'Protocols';

  @override
  String get diagnosisSectionProtocols => 'Treatment protocols';

  @override
  String get diagnosisProtocolMedicines => 'Medicine combinations';

  @override
  String get diagnosisProtocolPathogens => 'Pathogens';

  @override
  String get diagnosisProtocolCriteria => 'Criteria';

  @override
  String get diagnosisProtocolNoData => 'No matching protocol.';

  @override
  String get diagnosisProtocolSelect => 'Select a medicine combination';

  @override
  String get diagnosisProtocolNoMedicine => 'No medicine combination.';

  @override
  String get diagnosisSelectDrugs => 'Select antibiotics';

  @override
  String get diagnosisDrugSearch => 'Search medicines';

  @override
  String get diagnosisDrugSearchHint => 'Search by name or antibiotic group…';

  @override
  String diagnosisSelectedDrugs(int count) {
    return '$count antibiotics selected';
  }

  @override
  String get diagnosisProtocolAdherent => 'Adherent';

  @override
  String get diagnosisReasonRequired =>
      'Please enter a reason for the medicine choice.';

  @override
  String get diagnosisNonAdherentReason =>
      'The selected medicines do not match any protocol — please enter a reason.';

  @override
  String get diagnosisConfirmTreatment => 'Confirm treatment';

  @override
  String get diagnosisReason => 'Reason for medicine choice';

  @override
  String get diagnosisReasonHint =>
      'Required when choosing medicines outside the protocol';

  @override
  String get diagnosisWarnCombinationTitle => 'Antibiotic combination warning';

  @override
  String get diagnosisWarnCombinationDesc =>
      'The selected combination should be reviewed before prescribing.';

  @override
  String get diagnosisConfirmSuccess => 'Treatment result saved.';

  @override
  String get diagnosisConfirmFailed => 'Unable to save the treatment result.';

  @override
  String get diagnosisConfirmMissingResult => 'No diagnosis result to save.';

  @override
  String get diagnosisSelectMedicineRequired =>
      'Please select a medicine combination.';

  @override
  String get diagnosisNoProtocolToSave => 'No matching protocol to save.';

  @override
  String diagnosisEvidenceFormula(String formula) {
    return 'Formula: $formula';
  }

  @override
  String diagnosisEvidenceValue(String value) {
    return 'Value: $value';
  }

  @override
  String diagnosisEvidenceRelated(String variables) {
    return 'Related variables: $variables';
  }

  @override
  String diagnosisEvidenceMissing(String variables) {
    return 'Missing: $variables';
  }

  @override
  String get diagnosisMicrobialResultTitle => 'Microbiology result';

  @override
  String get diagnosisMicrobialAntibiotics => 'Susceptible antibiotics';

  @override
  String get diagnosisDiagnosisId => 'Diagnosis ID';

  @override
  String get infectionSkinSoftTissue => 'Skin and soft tissue infection';

  @override
  String get infectionSepticArthritis => 'Septic arthritis';

  @override
  String get infectionOsteomyelitis => 'Osteomyelitis';

  @override
  String get infectionBacterialMyositis =>
      'Bacterial myositis / muscle abscess';

  @override
  String get infectionInfectedGoutyTophus => 'Infected gouty tophus';

  @override
  String get infectionPyelonephritis => 'Pyelonephritis / renal abscess';

  @override
  String get infectionAcuteCystitis => 'Acute cystitis';

  @override
  String get infectionAcuteNonGonococcalUrethritis =>
      'Acute non-gonococcal urethritis';

  @override
  String get infectionBacterialVaginourethritis => 'Bacterial vaginourethritis';

  @override
  String get infectionBacterialEndometritis => 'Bacterial endometritis';

  @override
  String get infectionPurulentMeningitis => 'Purulent meningitis';

  @override
  String get infectionBacterialEncephalitis => 'Bacterial encephalitis';

  @override
  String get infectionPleuralEmpyema => 'Pleural empyema';

  @override
  String get infectionMediastinalAbscess => 'Mediastinal abscess';

  @override
  String get infectionInfectiveEndocarditis => 'Infective endocarditis';

  @override
  String get infectionBacterialMyocarditis => 'Bacterial myocarditis';

  @override
  String get infectionBacterialPericarditis => 'Bacterial pericarditis';

  @override
  String get infectionPulmonaryTuberculosis => 'Pulmonary tuberculosis';

  @override
  String get infectionExtrapulmonaryTuberculosis =>
      'Extrapulmonary tuberculosis';

  @override
  String get infectionBiliaryTract => 'Biliary tract infection';

  @override
  String get infectionBacterialLiverAbscess => 'Bacterial liver abscess';

  @override
  String get infectionInfectedAcutePancreatitis =>
      'Infected acute pancreatitis';

  @override
  String get infectionBacterialPeritonitis => 'Bacterial peritonitis';

  @override
  String get infectionBacterialDiarrhea => 'Bacterial diarrhea';

  @override
  String get infectionHelicobacterPylori => 'Helicobacter pylori infection';

  @override
  String get infectionSepsis => 'Sepsis';

  @override
  String get infectionOrbitalCellulitis => 'Orbital cellulitis';

  @override
  String get infectionConjunctivitis => 'Conjunctivitis';

  @override
  String get infectionKeratitis => 'Keratitis';

  @override
  String get infectionDacryocystitis => 'Dacryocystitis';

  @override
  String get infectionMaxillofacialAbscess => 'Maxillofacial abscess';

  @override
  String get infectionOther => 'Other';

  @override
  String get sampleSputum => 'Sputum';

  @override
  String get sampleBronchoalveolarLavageFluid => 'Bronchoalveolar lavage fluid';

  @override
  String get samplePleuralFluid => 'Pleural fluid';

  @override
  String get sampleUrine => 'Urine';

  @override
  String get sampleBlood => 'Blood';

  @override
  String get sampleAbdominalFluid => 'Abdominal fluid';

  @override
  String get sampleCerebrospinalFluid => 'Cerebrospinal fluid';

  @override
  String get sampleWoundExudate => 'Wound exudate';

  @override
  String get sampleOther => 'Other';

  @override
  String get micSusceptible => 'Susceptible';

  @override
  String get micIntermediate => 'Intermediate';

  @override
  String get micResistant => 'Resistant';

  @override
  String get routeIntravenous => 'Intravenous';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeIntramuscular => 'Intramuscular';

  @override
  String get routeAbbrevIv => 'IV';

  @override
  String get routeAbbrevOral => 'Oral';

  @override
  String get calculatorTitle => 'Calculators';

  @override
  String get calculatorSubtitle => 'Clinical calculation tools';

  @override
  String get calculatorCommonTools => 'Common tools';

  @override
  String calculatorComingSoon(String title) {
    return '\"$title\" calculator will be added later.';
  }

  @override
  String get calcCurb65Desc => 'Assess pneumonia severity';

  @override
  String get calcEgfrDesc => 'Estimate kidney function';

  @override
  String get calcCrclDesc => 'Creatinine clearance';

  @override
  String get calcBmiDesc => 'Body mass index';

  @override
  String get calcQsofaDesc => 'Quick assessment of infection risk';

  @override
  String get calcClinicalCalculator => 'Clinical calculator';

  @override
  String get calcInputTab => 'Input';

  @override
  String get calcExplanationTab => 'Explanation';

  @override
  String get calcCriteriaBanner => 'CURB-65 criteria';

  @override
  String get calcConfusion => 'New-onset confusion';

  @override
  String get calcConfusionDesc => 'Confusion';

  @override
  String get calcUrea => 'Urea';

  @override
  String get calcUreaDesc => 'Threshold > 7 mmol/L';

  @override
  String get calcRespRate => 'Respiratory rate';

  @override
  String get calcRespRateDesc => 'Threshold ≥ 30 breaths/min';

  @override
  String get calcRespRateUnit => 'breaths/min';

  @override
  String get calcBloodPressure => 'Blood pressure';

  @override
  String get calcBpThreshold => 'Threshold: SBP < 90 mmHg or DBP ≤ 60 mmHg';

  @override
  String get calcAge => 'Age';

  @override
  String get calcAgeDesc => 'Threshold ≥ 65 years';

  @override
  String get calcAgeUnit => 'years';

  @override
  String get calcCalculate => 'Calculate';

  @override
  String get calcMethodTitle => 'Calculation method';

  @override
  String get calcMethodBody =>
      'CURB-65 score = the total number of met criteria, from 0 to 5 points. Each met criterion contributes 1 point.';

  @override
  String get calcDescriptionTitle => 'Description';

  @override
  String get calcDescriptionBody =>
      'CURB-65 helps assess the severity of community-acquired pneumonia.';

  @override
  String get calcConfirmNote =>
      'Results should be confirmed by a physician in the clinical context.';

  @override
  String get calcComponentsTitle => 'Components';

  @override
  String get calcComponentsBody =>
      'Confusion · Urea > 7 mmol/L · Respiratory rate ≥ 30 · Low blood pressure · Age ≥ 65.';

  @override
  String get calcThresholdNote =>
      'Threshold details are shown in the Input tab.';

  @override
  String calcScorePoints(int score) {
    return '$score points';
  }

  @override
  String calcAdviceHigh(int score) {
    return 'Score $score → consider inpatient treatment';
  }

  @override
  String calcAdviceMedium(int score) {
    return 'Score $score → consider short-term admission';
  }

  @override
  String calcAdviceLow(int score) {
    return 'Score $score → outpatient treatment may be appropriate';
  }

  @override
  String get lookupTitle => 'Lookup';

  @override
  String get lookupSubtitle => 'Medical reference for physicians';

  @override
  String get lookupCategories => 'Categories';

  @override
  String get lookupSearchHint => 'Search drugs, bacteria, conditions...';

  @override
  String get categoryAntibioticGroups => 'Antibiotic groups';

  @override
  String get categoryAntibioticGroupsSub => 'Classification and description';

  @override
  String get categoryAntibiotics => 'Antibiotics';

  @override
  String get categoryAntibioticsSub => 'Dosage and spectrum';

  @override
  String get categoryPathogens => 'Pathogens';

  @override
  String get categoryPathogensSub => 'Description and susceptibility';

  @override
  String get categoryClinicalVariables => 'Clinical variables';

  @override
  String get categoryClinicalVariablesSub => 'Variables used by criteria';

  @override
  String get categorySuspectedCauses => 'Suspected causes';

  @override
  String get categorySuspectedCausesSub => 'By disease and severity';

  @override
  String get categoryCriteria => 'Criteria';

  @override
  String get categoryCriteriaSub => 'List of criteria';

  @override
  String get categoryRiskFactors => 'Risk factors';

  @override
  String get categoryRiskFactorsSub => 'Risk by pathogen';

  @override
  String get categoryClinicalScores => 'Clinical scores';

  @override
  String get categoryClinicalScoresSub => 'Criteria sets & assessment';

  @override
  String get categoryAntibiograms => 'Antibiograms';

  @override
  String get categoryAntibiogramsSub => 'MIC and antibiotics';

  @override
  String get categoryTreatmentProtocols => 'Treatment protocols';

  @override
  String get categoryTreatmentProtocolsSub => 'By severity & treatment site';

  @override
  String get recentItemDrugTitle => 'Ceftriaxone';

  @override
  String get recentItemDrugSubtitle => 'Third-generation cephalosporin';

  @override
  String get recentItemDrugTag => 'Drug';

  @override
  String get recentItemDiseaseTitle => 'Community-acquired pneumonia';

  @override
  String get recentItemDiseaseSubtitle => '5 assessment criteria';

  @override
  String get recentItemDiseaseTag => 'Disease';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statisticsSubtitle => 'Treatment activity overview';

  @override
  String get statisticsWeekly => 'Diagnoses by week';

  @override
  String get statisticsTopPathogens => 'Common pathogens';

  @override
  String get statisticsSynced => 'Data synced';

  @override
  String get statisticsUpdated => 'Updated at 19:28 today';

  @override
  String get periodLast30Days => '30 days';

  @override
  String get periodThisQuarter => 'This quarter';

  @override
  String get periodThisYear => 'This year';

  @override
  String get kpiDiagnoses => 'Diagnoses';

  @override
  String get kpiSaved => 'Saved';

  @override
  String get kpiMicrobiology => 'Microbiology';

  @override
  String statisticsWeek(int week) {
    return 'W$week';
  }

  @override
  String get antibioticTitle => 'Antibiotics';

  @override
  String get antibioticSubtitle => 'Active substance catalogue';

  @override
  String get antibioticSearchHint => 'Search antibiotics...';

  @override
  String get antibioticEmpty => 'No antibiotic data';

  @override
  String get antibioticDetailSubtitle => 'Antibiotic information';

  @override
  String get antibioticDosage => 'Dosage';

  @override
  String get antibioticStandardDose => 'Standard dose';

  @override
  String get antibioticNoInfo => 'No information yet';

  @override
  String get antibioticGfrAdjust => 'Adjust by GFR';

  @override
  String get antibioticGroupTitle => 'Antibiotic groups';

  @override
  String get antibioticGroupSubtitle => 'Classification and description';

  @override
  String get antibioticGroupSearchHint => 'Search groups...';

  @override
  String antibioticGroupDetailWithParent(String parent) {
    return 'Antibiotic group · $parent';
  }

  @override
  String get antibioticGroupDetail => 'Antibiotic group';

  @override
  String get antibioticGroupInfo => 'Group information';

  @override
  String get antibioticGroupParent => 'Parent group';

  @override
  String get antibioticGroupDescription => 'Description';

  @override
  String get antibioticGroupNone => 'None';

  @override
  String get antibioticGroupNoData => 'No data';

  @override
  String get antibioticGroupAntibioticsInGroup => 'Antibiotics in group';

  @override
  String get antibioticGroupLoadError => 'Unable to load data';

  @override
  String get antibioticGroupEmpty => 'No antibiotics in this group yet';

  @override
  String antibioticGroupClassification(String classification) {
    return 'Classification: $classification';
  }

  @override
  String get pathogenTitle => 'Pathogens';

  @override
  String get pathogenSubtitle => 'Description and susceptibility';

  @override
  String get pathogenSearchHint => 'Search pathogens...';

  @override
  String get pathogenAtypical => 'Atypical';

  @override
  String get pathogenDescription => 'Description';

  @override
  String get antibiogramTitle => 'Antibiograms';

  @override
  String get antibiogramSubtitle => 'Pathogen · MIC · antibiotics';

  @override
  String get antibiogramSearchHint => 'Search pathogen or antibiotic...';

  @override
  String get antibiogramEmpty => 'No antibiogram data yet.';

  @override
  String antibiogramAntibiotics(int count) {
    return 'Antibiotics ($count)';
  }

  @override
  String get treatmentProtocolTitle => 'Treatment protocols';

  @override
  String get treatmentProtocolSubtitle => 'Severity · site · antibiotics';

  @override
  String get treatmentProtocolSearchHint =>
      'Search pathogen, criteria, antibiotic...';

  @override
  String get treatmentProtocolEmpty => 'No treatment protocol yet.';

  @override
  String get treatmentProtocolApplied => 'Applied';

  @override
  String get treatmentProtocolNotApplied => 'Not applied';

  @override
  String get treatmentProtocolCriteria => 'Criteria';

  @override
  String get treatmentProtocolPathogens => 'Pathogens';

  @override
  String get treatmentProtocolCombinations => 'Antibiotic combinations';

  @override
  String get treatmentProtocolPublisher => 'Publisher';

  @override
  String get treatmentProtocolFilterSeverity => 'Severity';

  @override
  String get treatmentProtocolFilterSite => 'Treatment site';

  @override
  String get treatmentProtocolFilterPathogen => 'Pathogen';

  @override
  String get treatmentProtocolFilterCriteria => 'Criteria';

  @override
  String get treatmentProtocolFilterSearchPathogen => 'Search pathogen...';

  @override
  String get treatmentProtocolFilterSearchCriteria => 'Search criteria...';

  @override
  String treatmentProtocolFilterSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get treatmentProtocolFilterLoadFailed =>
      'Unable to load the filter options.';

  @override
  String get analysisTitle => 'Analysis reports';

  @override
  String get analysisSubtitle => 'Adherence & treatment outcomes';

  @override
  String get analysisEntryTitle => 'Treatment analysis reports';

  @override
  String get analysisEntrySubtitle => 'Adherence & outcomes by doctor';

  @override
  String get analysisEmpty => 'No analysis report yet.';

  @override
  String get analysisLoadFailed => 'Unable to load the analysis report.';

  @override
  String get analysisDetailTitle => 'Report detail';

  @override
  String get analysisDetailSubtitle => 'Adherence and outcome metrics';

  @override
  String get analysisPeriod => 'Analysis period';

  @override
  String analysisCreatedAt(String date) {
    return 'Created $date';
  }

  @override
  String get analysisAllDoctors => 'All doctors';

  @override
  String analysisDoctorFallback(String id) {
    return 'Doctor #$id';
  }

  @override
  String get analysisTotalPatients => 'Total patients';

  @override
  String get analysisTotalPlans => 'Total plans';

  @override
  String get analysisAdherenceRate => 'Adherence rate';

  @override
  String get analysisPendingRate => 'Pending review rate';

  @override
  String get analysisAdherent => 'Adherent';

  @override
  String get analysisNonAdherent => 'Non-adherent';

  @override
  String get analysisPendingReview => 'Pending review';

  @override
  String get analysisOutcomes => 'Treatment outcomes';

  @override
  String get analysisRecovered => 'Recovered';

  @override
  String get analysisDeceased => 'Deceased';

  @override
  String get analysisOtherOutcome => 'Other';

  @override
  String get analysisByDoctor => 'By doctor';

  @override
  String get analysisByMedicine => 'By medicine';

  @override
  String get analysisMedicine => 'Medicine';

  @override
  String get analysisClassification => 'Classification';

  @override
  String analysisPatientsCount(int count) {
    return '$count patients';
  }

  @override
  String analysisPlansCount(int count) {
    return '$count plans';
  }

  @override
  String get analysisNoDoctors => 'This report has no doctor data.';

  @override
  String get analysisNoMedicines => 'This report has no medicine data.';

  @override
  String get analysisNoData => 'No data yet.';

  @override
  String get nextOfKinSection => 'Emergency contacts';

  @override
  String get nextOfKinEmpty => 'No emergency contact yet';

  @override
  String get nextOfKinEmptyDesc =>
      'Add a relative to keep their contact details on file.';

  @override
  String get nextOfKinAdd => 'Add relative';

  @override
  String get nextOfKinAddTitle => 'Add relative';

  @override
  String get nextOfKinEditTitle => 'Edit relative';

  @override
  String get nextOfKinSubtitle => 'Patient contact information';

  @override
  String get nextOfKinInfoSection => 'Relative information';

  @override
  String get nextOfKinFullName => 'Full name';

  @override
  String get nextOfKinFullNameHint => 'Enter full name';

  @override
  String get nextOfKinRelationship => 'Relationship';

  @override
  String get nextOfKinRelationshipHint => 'Select relationship';

  @override
  String get nextOfKinPhone => 'Phone number';

  @override
  String get nextOfKinPhoneHint => '0912 345 678';

  @override
  String get nextOfKinSave => 'Save relative';

  @override
  String get nextOfKinUpdate => 'Save changes';

  @override
  String get nextOfKinMenuSemantic => 'Relative options';

  @override
  String get nextOfKinMenuEdit => 'Edit';

  @override
  String get nextOfKinMenuDelete => 'Delete';

  @override
  String get nextOfKinDeleteTitle => 'Delete relative?';

  @override
  String get nextOfKinDeleteDesc =>
      'Are you sure you want to remove this relative from the patient record? This action cannot be undone.';

  @override
  String get nextOfKinDeleteConfirm => 'Delete relative';

  @override
  String get nextOfKinDeleteSuccess => 'Relative deleted.';

  @override
  String get nextOfKinDeleteFailed => 'Unable to delete the relative.';

  @override
  String get nextOfKinCreateSuccess => 'Relative added.';

  @override
  String get nextOfKinCreateFailed => 'Unable to add the relative.';

  @override
  String get nextOfKinUpdateSuccess => 'Relative updated.';

  @override
  String get nextOfKinUpdateFailed => 'Unable to update the relative.';

  @override
  String get nextOfKinErrName => 'Please enter the relative\'s full name.';

  @override
  String get nextOfKinErrPhone => 'Invalid phone number.';

  @override
  String get nextOfKinErrRelationship => 'Please select a relationship.';

  @override
  String get nextOfKinRelationshipOther => 'Other';

  @override
  String get nextOfKinRelationshipOtherHint => 'Enter relationship';

  @override
  String get relationshipSpouse => 'Spouse';

  @override
  String get relationshipParent => 'Parent';

  @override
  String get relationshipChild => 'Child';

  @override
  String get relationshipSibling => 'Sibling';

  @override
  String get relationshipGrandparent => 'Grandparent';

  @override
  String get treatmentPlanDetailTitle => 'Treatment plan';

  @override
  String get treatmentPlanDetailSubtitle => 'Saved treatment information';

  @override
  String get treatmentPlanLoadFailed => 'Unable to load the treatment plan.';

  @override
  String get treatmentPlanStatusInProgress => 'In treatment';

  @override
  String get treatmentPlanStatusClosed => 'Closed';

  @override
  String get treatmentPlanSeverity => 'Severity';

  @override
  String get treatmentPlanSite => 'Treatment site';

  @override
  String get treatmentPlanAdherenceLabel => 'Adherence';

  @override
  String get treatmentPlanSuspected => 'Suspected etiology';

  @override
  String get treatmentPlanMedicines => 'Antibiotics';

  @override
  String get treatmentPlanNoMedicines => 'No antibiotic recorded.';

  @override
  String get treatmentPlanReasonForChoice => 'Reason for medicine choice';

  @override
  String get treatmentPlanClose => 'Close plan';

  @override
  String get treatmentPlanCloseTitle => 'Close treatment plan';

  @override
  String treatmentPlanCloseDescriptionPrefix(String name) {
    return '$name\'s treatment plan will be stopped. Once closed, the plan moves to the archive and ';
  }

  @override
  String get treatmentPlanCloseWarning => 'cannot be edited';

  @override
  String get treatmentPlanCloseDescriptionSuffix => ' any further.';

  @override
  String get treatmentPlanCloseReasonLabel => 'Reason for closing';

  @override
  String get treatmentPlanCloseReasonHint =>
      'Enter the reason for closing (recovered, transferred, protocol changed)...';

  @override
  String treatmentPlanCloseReasonCounter(int count) {
    return '$count/500 characters';
  }

  @override
  String get treatmentPlanCloseConfirm => 'Close plan';

  @override
  String get treatmentPlanCloseSuccess => 'Treatment plan closed.';

  @override
  String get treatmentPlanCloseFailed =>
      'Unable to close the plan. Please try again.';

  @override
  String get treatmentPlanErrReasonRequired =>
      'Please enter the reason for closing.';

  @override
  String get treatmentPlanViewSemantic => 'View treatment plan details';

  @override
  String get clinicalVariableTitle => 'Clinical variables';

  @override
  String get clinicalVariableSubtitle => 'Parameter management';

  @override
  String get clinicalVariableDetailTitle => 'Variable details';

  @override
  String get clinicalVariableSearchHint => 'Search by name or code...';

  @override
  String get clinicalVariableRequired => 'Required';

  @override
  String get clinicalVariableDetailConfig => 'Variable configuration';

  @override
  String get clinicalVariableValueType => 'Data type';

  @override
  String get clinicalVariableCanonicalUnit => 'Canonical unit';

  @override
  String get clinicalVariableIsRequired => 'Required';

  @override
  String get clinicalVariableRequiredYes => 'Required';

  @override
  String get clinicalVariableOptional => 'Optional';

  @override
  String get clinicalVariablePrerequisite => 'Prerequisite';

  @override
  String get clinicalVariableRange => 'Value range';

  @override
  String get clinicalVariableAccepted => 'Accepted';

  @override
  String get clinicalVariableNormal => 'Normal';

  @override
  String get clinicalVariableOptions => 'Options';

  @override
  String get valueTypeNumeric => 'Numeric';

  @override
  String get valueTypeBoolean => 'Yes / No';

  @override
  String get valueTypeCategorical => 'Categorical';

  @override
  String get valueTypeOther => 'Other';

  @override
  String get variableCategoryPersonal => 'Personal information';

  @override
  String get variableCategoryPersonalShort => 'Personal';

  @override
  String get variableCategoryMedicalHistory => 'Medical history';

  @override
  String get variableCategoryParaclinical => 'Paraclinical';

  @override
  String get variableCategoryClinical => 'Clinical';

  @override
  String get variableCategoryOther => 'Other';

  @override
  String get filterTitle => 'Data filters';

  @override
  String get filterRequired => 'Required';

  @override
  String get filterRequiredYes => 'Required';

  @override
  String get filterRequiredNo => 'Not required';

  @override
  String get filterCategory => 'Category';

  @override
  String get filterValueType => 'Value type';

  @override
  String get filterClear => 'Clear filters';

  @override
  String get filterApply => 'Apply';

  @override
  String rangeUnlimited(String unit) {
    return 'No limit$unit';
  }

  @override
  String rangeSingle(String symbol, String value, String unit) {
    return 'Value $symbol $value$unit';
  }

  @override
  String rangeBetween(
    String minSymbol,
    String min,
    String unit,
    String maxSymbol,
    String max,
  ) {
    return 'Value $minSymbol $min$unit and $maxSymbol $max$unit';
  }

  @override
  String get clinicalMetricTitle => 'Clinical scores';

  @override
  String get clinicalMetricSubtitle => 'Criteria sets & assessment';

  @override
  String get clinicalMetricSearchHint => 'Search score names...';

  @override
  String get clinicalMetricDetailTitle => 'Score details';

  @override
  String get clinicalMetricDetailSubtitle => 'Assessment score';

  @override
  String get clinicalMetricApplied => 'Applied';

  @override
  String clinicalMetricVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get clinicalMetricGeneral => 'General information';

  @override
  String get clinicalMetricCode => 'Code';

  @override
  String get clinicalMetricPublisher => 'Publisher';

  @override
  String get clinicalMetricDescription => 'Description';

  @override
  String get clinicalMetricMajor => 'Major criteria';

  @override
  String get clinicalMetricMinor => 'Minor criteria';

  @override
  String get clinicalMetricScoring => 'Scoring criteria';

  @override
  String clinicalMetricPoints(String points) {
    return '+ $points points';
  }

  @override
  String get criteriaTitle => 'Criteria';

  @override
  String get criteriaSubtitle => 'List of assessment criteria';

  @override
  String get criteriaSearchHint => 'Search criteria names...';

  @override
  String get riskFactorTitle => 'Risk factors';

  @override
  String get riskFactorSubtitle => 'By pathogen';

  @override
  String get riskFactorListLabel => 'Factor list';

  @override
  String get riskFactorDetailTitle => 'Factor details';

  @override
  String get riskFactorDetailSubtitle => 'Risk by pathogen';

  @override
  String get riskFactorPathogen => 'Related pathogen';

  @override
  String get riskFactorFormula => 'Condition formula';

  @override
  String get riskFactorLoadInfo => 'Unable to load information';

  @override
  String get riskFactorPathogensList => 'Unable to load the pathogen list';

  @override
  String get riskFactorAllPathogens => 'All pathogens';

  @override
  String get riskFactorPathogenLabel => 'Pathogen';

  @override
  String get suspectedCauseTitle => 'Suspected causes';

  @override
  String get suspectedCauseSubtitle => 'Severity & treatment setting';

  @override
  String get suspectedCauseListLabel => 'Pathogen list';

  @override
  String get suspectedCausePathogen => 'Pathogen';

  @override
  String get suspectedCauseSeverity => 'Severity';

  @override
  String get suspectedCauseSite => 'Treatment setting';
}
