import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('vi'),
    Locale('en'),
  ];

  /// No description provided for @commonRetry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get commonRetry;

  /// No description provided for @commonNoResults.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy kết quả nào.'**
  String get commonNoResults;

  /// No description provided for @commonLoadMoreFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải thêm. Nhấn để thử lại'**
  String get commonLoadMoreFailed;

  /// No description provided for @commonLoadDataError.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải dữ liệu'**
  String get commonLoadDataError;

  /// No description provided for @commonLoadInfoError.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được thông tin'**
  String get commonLoadInfoError;

  /// No description provided for @commonNoData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get commonNoData;

  /// No description provided for @commonYes.
  ///
  /// In vi, this message translates to:
  /// **'Có'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In vi, this message translates to:
  /// **'Không'**
  String get commonNo;

  /// No description provided for @commonDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get commonDescription;

  /// No description provided for @commonCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã'**
  String get commonCode;

  /// No description provided for @commonApply.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng'**
  String get commonApply;

  /// No description provided for @commonClearFilters.
  ///
  /// In vi, this message translates to:
  /// **'Xóa bộ lọc'**
  String get commonClearFilters;

  /// No description provided for @commonAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get commonAll;

  /// No description provided for @commonFilters.
  ///
  /// In vi, this message translates to:
  /// **'Bộ lọc dữ liệu'**
  String get commonFilters;

  /// No description provided for @commonCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get commonCancel;

  /// No description provided for @commonBack.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get commonBack;

  /// No description provided for @commonComingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng đang phát triển.'**
  String get commonComingSoon;

  /// No description provided for @commonTabComingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Tab \"{label}\" sẽ được bổ sung sau.'**
  String commonTabComingSoon(String label);

  /// No description provided for @commonFeatureComingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng {feature} đang phát triển'**
  String commonFeatureComingSoon(String feature);

  /// No description provided for @commonNotAvailable.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có thông tin'**
  String get commonNotAvailable;

  /// No description provided for @commonNone.
  ///
  /// In vi, this message translates to:
  /// **'Không có'**
  String get commonNone;

  /// No description provided for @commonOptional.
  ///
  /// In vi, this message translates to:
  /// **'Tùy chọn'**
  String get commonOptional;

  /// No description provided for @commonRequired.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc nhập'**
  String get commonRequired;

  /// No description provided for @commonActive.
  ///
  /// In vi, this message translates to:
  /// **'Đang áp dụng'**
  String get commonActive;

  /// No description provided for @commonVersion.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản: {version}'**
  String commonVersion(String version);

  /// No description provided for @commonPoints.
  ///
  /// In vi, this message translates to:
  /// **'{score} điểm'**
  String commonPoints(String score);

  /// No description provided for @commonAddPoints.
  ///
  /// In vi, this message translates to:
  /// **'+ {score} điểm'**
  String commonAddPoints(String score);

  /// No description provided for @commonLoading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải...'**
  String get commonLoading;

  /// No description provided for @commonLoadFailedShort.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi tải dữ liệu'**
  String get commonLoadFailedShort;

  /// No description provided for @navPatients.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh nhân'**
  String get navPatients;

  /// No description provided for @navLookup.
  ///
  /// In vi, this message translates to:
  /// **'Tra cứu'**
  String get navLookup;

  /// No description provided for @navDiagnosis.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán'**
  String get navDiagnosis;

  /// No description provided for @navCalculators.
  ///
  /// In vi, this message translates to:
  /// **'Máy tính'**
  String get navCalculators;

  /// No description provided for @navStatistics.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get navStatistics;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Cá nhân hóa trải nghiệm'**
  String get settingsSubtitle;

  /// No description provided for @settingsOpen.
  ///
  /// In vi, this message translates to:
  /// **'Mở cài đặt'**
  String get settingsOpen;

  /// No description provided for @settingsClose.
  ///
  /// In vi, this message translates to:
  /// **'Đóng cài đặt'**
  String get settingsClose;

  /// No description provided for @settingsProfileSpecialty.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên khoa Hô hấp'**
  String get settingsProfileSpecialty;

  /// No description provided for @settingsDoctorFallback.
  ///
  /// In vi, this message translates to:
  /// **'Bác sĩ'**
  String get settingsDoctorFallback;

  /// No description provided for @doctorProfileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ bác sĩ'**
  String get doctorProfileTitle;

  /// No description provided for @doctorProfileSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản'**
  String get doctorProfileSubtitle;

  /// No description provided for @doctorProfileOpen.
  ///
  /// In vi, this message translates to:
  /// **'Mở hồ sơ bác sĩ'**
  String get doctorProfileOpen;

  /// No description provided for @doctorProfileSectionProfessional.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên môn'**
  String get doctorProfileSectionProfessional;

  /// No description provided for @doctorProfileSectionContact.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ'**
  String get doctorProfileSectionContact;

  /// No description provided for @doctorProfileSectionPersonal.
  ///
  /// In vi, this message translates to:
  /// **'Cá nhân'**
  String get doctorProfileSectionPersonal;

  /// No description provided for @doctorProfileAcademicTitle.
  ///
  /// In vi, this message translates to:
  /// **'Học hàm / học vị'**
  String get doctorProfileAcademicTitle;

  /// No description provided for @doctorProfileDegrees.
  ///
  /// In vi, this message translates to:
  /// **'Bằng cấp'**
  String get doctorProfileDegrees;

  /// No description provided for @doctorProfilePosition.
  ///
  /// In vi, this message translates to:
  /// **'Chức vụ'**
  String get doctorProfilePosition;

  /// No description provided for @doctorProfileRole.
  ///
  /// In vi, this message translates to:
  /// **'Vai trò'**
  String get doctorProfileRole;

  /// No description provided for @doctorProfileEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get doctorProfileEmail;

  /// No description provided for @doctorProfilePhone.
  ///
  /// In vi, this message translates to:
  /// **'Điện thoại'**
  String get doctorProfilePhone;

  /// No description provided for @doctorProfileAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ'**
  String get doctorProfileAddress;

  /// No description provided for @doctorProfileGender.
  ///
  /// In vi, this message translates to:
  /// **'Giới tính'**
  String get doctorProfileGender;

  /// No description provided for @doctorProfileCitizenId.
  ///
  /// In vi, this message translates to:
  /// **'CCCD'**
  String get doctorProfileCitizenId;

  /// No description provided for @doctorProfileRoleDoctor.
  ///
  /// In vi, this message translates to:
  /// **'Bác sĩ'**
  String get doctorProfileRoleDoctor;

  /// No description provided for @doctorProfileRoleAdmin.
  ///
  /// In vi, this message translates to:
  /// **'Quản trị viên'**
  String get doctorProfileRoleAdmin;

  /// No description provided for @doctorProfileGenderOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get doctorProfileGenderOther;

  /// No description provided for @doctorProfileError.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được hồ sơ bác sĩ.'**
  String get doctorProfileError;

  /// No description provided for @doctorProfileEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có thông tin hồ sơ.'**
  String get doctorProfileEmpty;

  /// No description provided for @doctorProfileRetry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get doctorProfileRetry;

  /// No description provided for @settingsAppearance.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Sáng hoặc tối'**
  String get settingsThemeSubtitle;

  /// No description provided for @settingsThemeSheetTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chế độ hiển thị'**
  String get settingsThemeSheetTitle;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In vi, this message translates to:
  /// **'Hệ thống'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In vi, this message translates to:
  /// **'Sáng'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In vi, this message translates to:
  /// **'Tối'**
  String get settingsThemeDark;

  /// No description provided for @settingsFontSize.
  ///
  /// In vi, this message translates to:
  /// **'Cỡ chữ'**
  String get settingsFontSize;

  /// No description provided for @settingsTextSmall.
  ///
  /// In vi, this message translates to:
  /// **'Nhỏ'**
  String get settingsTextSmall;

  /// No description provided for @settingsTextStandard.
  ///
  /// In vi, this message translates to:
  /// **'Mặc định'**
  String get settingsTextStandard;

  /// No description provided for @settingsTextLarge.
  ///
  /// In vi, this message translates to:
  /// **'Lớn'**
  String get settingsTextLarge;

  /// No description provided for @settingsLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageVietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get settingsLanguageVietnamese;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLogout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất?'**
  String get settingsLogoutConfirmTitle;

  /// No description provided for @settingsLogoutConfirmBody.
  ///
  /// In vi, this message translates to:
  /// **'Bạn sẽ cần đăng nhập lại để tiếp tục sử dụng RespiraAMS.'**
  String get settingsLogoutConfirmBody;

  /// No description provided for @splashSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Không gian làm việc lâm sàng cho hô hấp'**
  String get splashSubtitle;

  /// No description provided for @authLoginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục vào không gian làm việc RespiraAMS.'**
  String get authLoginSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mã nhân viên'**
  String get authEmailLabel;

  /// No description provided for @authPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get authPasswordLabel;

  /// No description provided for @authForgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get authForgotPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get authLoginButton;

  /// No description provided for @authOr.
  ///
  /// In vi, this message translates to:
  /// **'hoặc'**
  String get authOr;

  /// No description provided for @authUseStaffCode.
  ///
  /// In vi, this message translates to:
  /// **'Dùng mã nhân viên'**
  String get authUseStaffCode;

  /// No description provided for @authStaffCodeComingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập bằng mã nhân viên sẽ được bổ sung sau.'**
  String get authStaffCodeComingSoon;

  /// No description provided for @authSecureSessionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phiên đăng nhập an toàn'**
  String get authSecureSessionTitle;

  /// No description provided for @authSecureSessionBody.
  ///
  /// In vi, this message translates to:
  /// **'Tự động khóa khi không hoạt động và bảo vệ theo vai trò.'**
  String get authSecureSessionBody;

  /// No description provided for @authSupportFooter.
  ///
  /// In vi, this message translates to:
  /// **'Cần hỗ trợ? Liên hệ quản trị viên bệnh viện.'**
  String get authSupportFooter;

  /// No description provided for @authMissingCredentials.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập email/mã nhân viên và mật khẩu.'**
  String get authMissingCredentials;

  /// No description provided for @authEmailInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Email chưa đúng định dạng.'**
  String get authEmailInvalid;

  /// No description provided for @authServerUnreachable.
  ///
  /// In vi, this message translates to:
  /// **'Không thể kết nối máy chủ. Vui lòng thử lại.'**
  String get authServerUnreachable;

  /// No description provided for @authForgotTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get authForgotTitle;

  /// No description provided for @authForgotBody.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email công việc. Hệ thống sẽ gửi mã xác thực gồm 6 chữ số.'**
  String get authForgotBody;

  /// No description provided for @authWorkEmailLabel.
  ///
  /// In vi, this message translates to:
  /// **'Email công việc'**
  String get authWorkEmailLabel;

  /// No description provided for @authSendCode.
  ///
  /// In vi, this message translates to:
  /// **'Gửi mã xác thực'**
  String get authSendCode;

  /// No description provided for @authBackToLogin.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại đăng nhập'**
  String get authBackToLogin;

  /// No description provided for @authNoEmailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được email?'**
  String get authNoEmailTitle;

  /// No description provided for @authNoEmailBody.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm tra thư rác hoặc liên hệ quản trị viên để xác minh tài khoản.'**
  String get authNoEmailBody;

  /// No description provided for @authOtpTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã xác thực'**
  String get authOtpTitle;

  /// No description provided for @authOtpSentTo.
  ///
  /// In vi, this message translates to:
  /// **'Mã 6 chữ số đã được gửi đến {email}'**
  String authOtpSentTo(String email);

  /// No description provided for @authResend.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã'**
  String get authResend;

  /// No description provided for @authResendIn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã sau 00:{seconds}'**
  String authResendIn(String seconds);

  /// No description provided for @authConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get authConfirm;

  /// No description provided for @authAccountSecurityTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật tài khoản'**
  String get authAccountSecurityTitle;

  /// No description provided for @authAccountSecurityBody.
  ///
  /// In vi, this message translates to:
  /// **'Không chia sẻ mã xác thực. Mã sẽ hết hiệu lực sau 10 phút và chỉ dùng một lần.'**
  String get authAccountSecurityBody;

  /// No description provided for @authChangeEmail.
  ///
  /// In vi, this message translates to:
  /// **'Đổi email nhận mã'**
  String get authChangeEmail;

  /// No description provided for @authStepIdentity.
  ///
  /// In vi, this message translates to:
  /// **'Bước 1/2 · Xác minh danh tính'**
  String get authStepIdentity;

  /// No description provided for @authNewPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tạo mật khẩu mới'**
  String get authNewPasswordTitle;

  /// No description provided for @authNewPasswordBody.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mật khẩu mạnh để bảo vệ dữ liệu bệnh nhân và phiên làm việc.'**
  String get authNewPasswordBody;

  /// No description provided for @authNewPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get authNewPasswordLabel;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authPasswordRequirements.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu cần có'**
  String get authPasswordRequirements;

  /// No description provided for @authMinLength.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 8 ký tự'**
  String get authMinLength;

  /// No description provided for @authUppercase.
  ///
  /// In vi, this message translates to:
  /// **'Ít nhất 1 chữ in hoa'**
  String get authUppercase;

  /// No description provided for @authDigitOrSpecial.
  ///
  /// In vi, this message translates to:
  /// **'Ít nhất 1 số hoặc ký tự đặc biệt'**
  String get authDigitOrSpecial;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu xác nhận chưa khớp.'**
  String get authPasswordMismatch;

  /// No description provided for @authUpdatePassword.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật mật khẩu'**
  String get authUpdatePassword;

  /// No description provided for @authCancelBack.
  ///
  /// In vi, this message translates to:
  /// **'Hủy và quay lại'**
  String get authCancelBack;

  /// No description provided for @authStepPassword.
  ///
  /// In vi, this message translates to:
  /// **'Bước 2/2 · Thiết lập mật khẩu'**
  String get authStepPassword;

  /// No description provided for @authResetSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu đã được cập nhật'**
  String get authResetSuccessTitle;

  /// No description provided for @authResetSuccessBody.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có thể đăng nhập lại và tiếp tục công việc trên RespiraAMS.'**
  String get authResetSuccessBody;

  /// No description provided for @authDemoDoctorName.
  ///
  /// In vi, this message translates to:
  /// **'BS. Lê Hoàng Minh'**
  String get authDemoDoctorName;

  /// No description provided for @authDoctorRoleVerified.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên khoa Hô hấp · Tài khoản đã xác minh'**
  String get authDoctorRoleVerified;

  /// No description provided for @authWorkspaceReady.
  ///
  /// In vi, this message translates to:
  /// **'Không gian làm việc đã sẵn sàng'**
  String get authWorkspaceReady;

  /// No description provided for @authRestoreAccess.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu và quyền truy cập sẽ được khôi phục sau đăng nhập.'**
  String get authRestoreAccess;

  /// No description provided for @authLoginNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get authLoginNow;

  /// No description provided for @authBackToWelcome.
  ///
  /// In vi, this message translates to:
  /// **'Về trang chào mừng'**
  String get authBackToWelcome;

  /// No description provided for @authWorkspaceEyebrow.
  ///
  /// In vi, this message translates to:
  /// **'KHÔNG GIAN LÀM VIỆC LÂM SÀNG'**
  String get authWorkspaceEyebrow;

  /// No description provided for @authWelcomeGreeting.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng, {name}'**
  String authWelcomeGreeting(String name);

  /// No description provided for @authWelcomeSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Sẵn sàng theo dõi các ca hô hấp hôm nay.'**
  String get authWelcomeSubtitle;

  /// No description provided for @authWelcomeBulletPatients.
  ///
  /// In vi, this message translates to:
  /// **'12 bệnh nhân đang theo dõi'**
  String get authWelcomeBulletPatients;

  /// No description provided for @authWelcomeBulletAttention.
  ///
  /// In vi, this message translates to:
  /// **'3 ca cần chú ý trong ngày'**
  String get authWelcomeBulletAttention;

  /// No description provided for @authWelcomeBulletSynced.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu đồng bộ lúc 19:28'**
  String get authWelcomeBulletSynced;

  /// No description provided for @authStart.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get authStart;

  /// No description provided for @authPrivacyFooter.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu y tế được bảo vệ theo phân quyền hệ thống.'**
  String get authPrivacyFooter;

  /// No description provided for @commonTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get commonTryAgain;

  /// No description provided for @commonEnterNumber.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số'**
  String get commonEnterNumber;

  /// No description provided for @commonServerUnreachable.
  ///
  /// In vi, this message translates to:
  /// **'Không thể kết nối máy chủ. Vui lòng kiểm tra kết nối mạng.'**
  String get commonServerUnreachable;

  /// No description provided for @commonBadRequest.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu không hợp lệ (mã {status}).'**
  String commonBadRequest(int status);

  /// No description provided for @commonLoadErrorWith.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải dữ liệu: {error}'**
  String commonLoadErrorWith(String error);

  /// No description provided for @commonLoadInfoErrorWith.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được thông tin: {error}'**
  String commonLoadInfoErrorWith(String error);

  /// No description provided for @commonOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get commonOther;

  /// No description provided for @commonYesNo.
  ///
  /// In vi, this message translates to:
  /// **'Có / Không'**
  String get commonYesNo;

  /// No description provided for @commonMlPerMin.
  ///
  /// In vi, this message translates to:
  /// **'mL/phút'**
  String get commonMlPerMin;

  /// No description provided for @genderMale.
  ///
  /// In vi, this message translates to:
  /// **'Nam'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In vi, this message translates to:
  /// **'Nữ'**
  String get genderFemale;

  /// No description provided for @patientStatusTreating.
  ///
  /// In vi, this message translates to:
  /// **'Đang điều trị'**
  String get patientStatusTreating;

  /// No description provided for @patientStatusRecovered.
  ///
  /// In vi, this message translates to:
  /// **'Hồi phục'**
  String get patientStatusRecovered;

  /// No description provided for @patientStatusDeceased.
  ///
  /// In vi, this message translates to:
  /// **'Tử vong'**
  String get patientStatusDeceased;

  /// No description provided for @patientStatusOutOfScope.
  ///
  /// In vi, this message translates to:
  /// **'Ngoài phạm vi điều trị'**
  String get patientStatusOutOfScope;

  /// No description provided for @patientAge.
  ///
  /// In vi, this message translates to:
  /// **'{age} tuổi'**
  String patientAge(int age);

  /// No description provided for @patientListTitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách bệnh nhân'**
  String get patientListTitle;

  /// No description provided for @patientFollowingCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} bệnh nhân đang theo dõi'**
  String patientFollowingCount(int count);

  /// No description provided for @patientFilterAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get patientFilterAll;

  /// No description provided for @patientFilterAttention.
  ///
  /// In vi, this message translates to:
  /// **'Cần chú ý'**
  String get patientFilterAttention;

  /// No description provided for @patientFilterHighRisk.
  ///
  /// In vi, this message translates to:
  /// **'Nguy cơ cao'**
  String get patientFilterHighRisk;

  /// No description provided for @patientCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} bệnh nhân'**
  String patientCount(int count);

  /// No description provided for @patientPrioritySort.
  ///
  /// In vi, this message translates to:
  /// **'Ưu tiên'**
  String get patientPrioritySort;

  /// No description provided for @patientSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm theo tên hoặc mã bệnh án'**
  String get patientSearchHint;

  /// No description provided for @patientAddSemantic.
  ///
  /// In vi, this message translates to:
  /// **'Thêm bệnh nhân'**
  String get patientAddSemantic;

  /// No description provided for @patientEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy bệnh nhân phù hợp.'**
  String get patientEmpty;

  /// No description provided for @patientDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết bệnh nhân'**
  String get patientDetailTitle;

  /// No description provided for @patientDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin chỉ đọc và tiến trình điều trị'**
  String get patientDetailSubtitle;

  /// No description provided for @patientProfileError.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải hồ sơ bệnh nhân.'**
  String get patientProfileError;

  /// No description provided for @patientNoSelection.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn bệnh nhân.'**
  String get patientNoSelection;

  /// No description provided for @patientRecordSection.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin hồ sơ'**
  String get patientRecordSection;

  /// No description provided for @patientDobGender.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh · Giới tính'**
  String get patientDobGender;

  /// No description provided for @patientInsurance.
  ///
  /// In vi, this message translates to:
  /// **'BHYT'**
  String get patientInsurance;

  /// No description provided for @patientAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ'**
  String get patientAddress;

  /// No description provided for @patientVitals.
  ///
  /// In vi, this message translates to:
  /// **'Thể trạng'**
  String get patientVitals;

  /// No description provided for @patientTreatmentStatus.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái điều trị'**
  String get patientTreatmentStatus;

  /// No description provided for @patientProgressSection.
  ///
  /// In vi, this message translates to:
  /// **'Tiến trình điều trị'**
  String get patientProgressSection;

  /// No description provided for @patientNoProgress.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có diễn biến điều trị.'**
  String get patientNoProgress;

  /// No description provided for @patientAddTreatment.
  ///
  /// In vi, this message translates to:
  /// **'Thêm điều trị'**
  String get patientAddTreatment;

  /// No description provided for @patientUpdateStatus.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật trạng thái'**
  String get patientUpdateStatus;

  /// No description provided for @patientEpisode.
  ///
  /// In vi, this message translates to:
  /// **'Đợt {index}'**
  String patientEpisode(int index);

  /// No description provided for @patientSavedTreatment.
  ///
  /// In vi, this message translates to:
  /// **'Điều trị đã lưu'**
  String get patientSavedTreatment;

  /// No description provided for @treatmentPlanInProgress.
  ///
  /// In vi, this message translates to:
  /// **'Đang thực hiện'**
  String get treatmentPlanInProgress;

  /// No description provided for @treatmentPlanClosed.
  ///
  /// In vi, this message translates to:
  /// **'Đã kết thúc'**
  String get treatmentPlanClosed;

  /// No description provided for @adherenceAdhere.
  ///
  /// In vi, this message translates to:
  /// **'Tuân thủ phác đồ'**
  String get adherenceAdhere;

  /// No description provided for @adherenceNotAdhere.
  ///
  /// In vi, this message translates to:
  /// **'Không tuân thủ'**
  String get adherenceNotAdhere;

  /// No description provided for @adherenceNotAdhereValid.
  ///
  /// In vi, this message translates to:
  /// **'Không tuân thủ (chấp nhận)'**
  String get adherenceNotAdhereValid;

  /// No description provided for @adherenceNotAdhereInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Không tuân thủ (không hợp lệ)'**
  String get adherenceNotAdhereInvalid;

  /// No description provided for @patientAddTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm bệnh nhân'**
  String get patientAddTitle;

  /// No description provided for @patientAddSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tạo hồ sơ bệnh nhân mới'**
  String get patientAddSubtitle;

  /// No description provided for @patientLastName.
  ///
  /// In vi, this message translates to:
  /// **'Họ'**
  String get patientLastName;

  /// No description provided for @patientFirstName.
  ///
  /// In vi, this message translates to:
  /// **'Tên'**
  String get patientFirstName;

  /// No description provided for @patientRecordCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã bệnh án'**
  String get patientRecordCode;

  /// No description provided for @patientDob.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get patientDob;

  /// No description provided for @patientInsuranceCard.
  ///
  /// In vi, this message translates to:
  /// **'Số thẻ BHYT'**
  String get patientInsuranceCard;

  /// No description provided for @patientPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get patientPhone;

  /// No description provided for @patientHeight.
  ///
  /// In vi, this message translates to:
  /// **'Chiều cao'**
  String get patientHeight;

  /// No description provided for @patientWeight.
  ///
  /// In vi, this message translates to:
  /// **'Cân nặng'**
  String get patientWeight;

  /// No description provided for @patientProvince.
  ///
  /// In vi, this message translates to:
  /// **'Tỉnh/Thành phố'**
  String get patientProvince;

  /// No description provided for @patientGender.
  ///
  /// In vi, this message translates to:
  /// **'Giới tính'**
  String get patientGender;

  /// No description provided for @patientSaving.
  ///
  /// In vi, this message translates to:
  /// **'Đang lưu…'**
  String get patientSaving;

  /// No description provided for @patientSaveRecord.
  ///
  /// In vi, this message translates to:
  /// **'Lưu hồ sơ'**
  String get patientSaveRecord;

  /// No description provided for @patientErrName.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập họ và tên.'**
  String get patientErrName;

  /// No description provided for @patientErrCode.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mã bệnh án.'**
  String get patientErrCode;

  /// No description provided for @patientErrDob.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập ngày sinh.'**
  String get patientErrDob;

  /// No description provided for @patientErrDobFormat.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh không hợp lệ (định dạng dd/MM/yyyy).'**
  String get patientErrDobFormat;

  /// No description provided for @patientErrPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ.'**
  String get patientErrPhone;

  /// No description provided for @patientErrInsurance.
  ///
  /// In vi, this message translates to:
  /// **'Số thẻ BHYT phải gồm 10 chữ số.'**
  String get patientErrInsurance;

  /// No description provided for @patientErrHeight.
  ///
  /// In vi, this message translates to:
  /// **'Chiều cao phải lớn hơn 0.'**
  String get patientErrHeight;

  /// No description provided for @patientErrWeight.
  ///
  /// In vi, this message translates to:
  /// **'Cân nặng phải lớn hơn 0.'**
  String get patientErrWeight;

  /// No description provided for @patientErrAddress.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập địa chỉ.'**
  String get patientErrAddress;

  /// No description provided for @patientErrCity.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tỉnh/thành phố.'**
  String get patientErrCity;

  /// No description provided for @patientCreateFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tạo bệnh nhân. Vui lòng thử lại.'**
  String get patientCreateFailed;

  /// No description provided for @patientMenuSemantic.
  ///
  /// In vi, this message translates to:
  /// **'Tùy chọn bệnh nhân'**
  String get patientMenuSemantic;

  /// No description provided for @patientMenuEdit.
  ///
  /// In vi, this message translates to:
  /// **'Edit'**
  String get patientMenuEdit;

  /// No description provided for @patientMenuDelete.
  ///
  /// In vi, this message translates to:
  /// **'Delete'**
  String get patientMenuDelete;

  /// No description provided for @patientEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa bệnh nhân'**
  String get patientEditTitle;

  /// No description provided for @patientEditSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thông tin hành chính & lâm sàng'**
  String get patientEditSubtitle;

  /// No description provided for @patientEditCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy bỏ'**
  String get patientEditCancel;

  /// No description provided for @patientEditSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu cập nhật'**
  String get patientEditSave;

  /// No description provided for @patientEditSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã cập nhật bệnh nhân.'**
  String get patientEditSuccess;

  /// No description provided for @patientEditFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể cập nhật bệnh nhân.'**
  String get patientEditFailed;

  /// No description provided for @patientEditLoadFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải hồ sơ bệnh nhân.'**
  String get patientEditLoadFailed;

  /// No description provided for @patientEditClinicalLocked.
  ///
  /// In vi, this message translates to:
  /// **'Không thể sửa ngày sinh, giới tính, cân nặng và chiều cao sau khi bệnh nhân đã có điều trị.'**
  String get patientEditClinicalLocked;

  /// No description provided for @patientFullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên bệnh nhân'**
  String get patientFullName;

  /// No description provided for @patientSectionAdmin.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin hành chính'**
  String get patientSectionAdmin;

  /// No description provided for @patientSectionVitals.
  ///
  /// In vi, this message translates to:
  /// **'Thể trạng'**
  String get patientSectionVitals;

  /// No description provided for @patientRequiredHint.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc (*)'**
  String get patientRequiredHint;

  /// No description provided for @patientDeleteTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa bệnh nhân'**
  String get patientDeleteTitle;

  /// No description provided for @patientDeleteDescription.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ bệnh nhân sẽ bị xóa vĩnh viễn. Thao tác này không thể hoàn tác.'**
  String get patientDeleteDescription;

  /// No description provided for @patientDeleteConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get patientDeleteConfirm;

  /// No description provided for @patientDeleteSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa bệnh nhân.'**
  String get patientDeleteSuccess;

  /// No description provided for @patientDeleteFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể xóa bệnh nhân.'**
  String get patientDeleteFailed;

  /// No description provided for @patientDischarge.
  ///
  /// In vi, this message translates to:
  /// **'Xuất viện'**
  String get patientDischarge;

  /// No description provided for @patientDischargeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xuất viện bệnh nhân'**
  String get patientDischargeTitle;

  /// No description provided for @patientDischargeAdmission.
  ///
  /// In vi, this message translates to:
  /// **'Ngày nhập viện'**
  String get patientDischargeAdmission;

  /// No description provided for @patientDischargeOutcomeLabel.
  ///
  /// In vi, this message translates to:
  /// **'KẾT QUẢ ĐIỀU TRỊ *'**
  String get patientDischargeOutcomeLabel;

  /// No description provided for @patientDischargeRecovered.
  ///
  /// In vi, this message translates to:
  /// **'Hồi phục'**
  String get patientDischargeRecovered;

  /// No description provided for @patientDischargeRecoveredDesc.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh nhân thuyên giảm triệu chứng, đủ điều kiện ra viện'**
  String get patientDischargeRecoveredDesc;

  /// No description provided for @patientDischargeDeath.
  ///
  /// In vi, this message translates to:
  /// **'Tử vong'**
  String get patientDischargeDeath;

  /// No description provided for @patientDischargeDeathDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhận tử vong trong quá trình điều trị nội trú'**
  String get patientDischargeDeathDesc;

  /// No description provided for @patientDischargeOutOfScope.
  ///
  /// In vi, this message translates to:
  /// **'Ngoài phạm vi điều trị'**
  String get patientDischargeOutOfScope;

  /// No description provided for @patientDischargeOutOfScopeDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chuyển viện tuyến trên hoặc gia đình xin về'**
  String get patientDischargeOutOfScopeDesc;

  /// No description provided for @patientDischargeSelected.
  ///
  /// In vi, this message translates to:
  /// **'Đã chọn kết quả: {outcome}. Sẵn sàng lưu vào hệ thống bệnh án.'**
  String patientDischargeSelected(String outcome);

  /// No description provided for @patientDischargeConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận xuất viện'**
  String get patientDischargeConfirm;

  /// No description provided for @patientDischargeCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy bỏ'**
  String get patientDischargeCancel;

  /// No description provided for @patientDischargeSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã xuất viện bệnh nhân.'**
  String get patientDischargeSuccess;

  /// No description provided for @patientDischargeFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể xuất viện. Vui lòng thử lại.'**
  String get patientDischargeFailed;

  /// No description provided for @patientDischargedBanner.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh nhân đã xuất viện'**
  String get patientDischargedBanner;

  /// No description provided for @patientDischargedAt.
  ///
  /// In vi, this message translates to:
  /// **'{date} · {outcome}'**
  String patientDischargedAt(String date, String outcome);

  /// No description provided for @progressTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm diễn biến'**
  String get progressTitle;

  /// No description provided for @progressSubtitleTargeted.
  ///
  /// In vi, this message translates to:
  /// **'Dựa trên kết quả vi sinh đã có'**
  String get progressSubtitleTargeted;

  /// No description provided for @progressSubtitleEmpirical.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhận thay đổi điều trị mới nhất'**
  String get progressSubtitleEmpirical;

  /// No description provided for @progressTreatmentTypeNext.
  ///
  /// In vi, this message translates to:
  /// **'Loại điều trị tiếp theo'**
  String get progressTreatmentTypeNext;

  /// No description provided for @progressTreatmentType.
  ///
  /// In vi, this message translates to:
  /// **'Loại điều trị'**
  String get progressTreatmentType;

  /// No description provided for @progressContinueTargeted.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục điều trị đích'**
  String get progressContinueTargeted;

  /// No description provided for @progressSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu diễn biến'**
  String get progressSave;

  /// No description provided for @progressReason.
  ///
  /// In vi, this message translates to:
  /// **'Lý do thay đổi'**
  String get progressReason;

  /// No description provided for @progressHasMicro.
  ///
  /// In vi, this message translates to:
  /// **'Có kết quả vi sinh'**
  String get progressHasMicro;

  /// No description provided for @progressHasMicroDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chuyển sang điều trị đích khi phù hợp.'**
  String get progressHasMicroDesc;

  /// No description provided for @progressPoorResponse.
  ///
  /// In vi, this message translates to:
  /// **'Đáp ứng kém'**
  String get progressPoorResponse;

  /// No description provided for @progressPoorResponseDesc.
  ///
  /// In vi, this message translates to:
  /// **'Triệu chứng không cải thiện sau theo dõi.'**
  String get progressPoorResponseDesc;

  /// No description provided for @progressLockTitle.
  ///
  /// In vi, this message translates to:
  /// **'Không thể chỉnh sửa sau khi lưu'**
  String get progressLockTitle;

  /// No description provided for @progressLockDesc.
  ///
  /// In vi, this message translates to:
  /// **'Tạo diễn biến mới nếu cần cập nhật tiếp.'**
  String get progressLockDesc;

  /// No description provided for @progressTargetedAlertTitle.
  ///
  /// In vi, this message translates to:
  /// **'Điều trị đích dựa trên kết quả vi sinh'**
  String get progressTargetedAlertTitle;

  /// No description provided for @progressTargetedAlertDesc.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm tra tác nhân và kháng sinh đồ trước khi chọn thuốc.'**
  String get progressTargetedAlertDesc;

  /// No description provided for @treatmentEmpirical.
  ///
  /// In vi, this message translates to:
  /// **'Kinh nghiệm'**
  String get treatmentEmpirical;

  /// No description provided for @treatmentTargeted.
  ///
  /// In vi, this message translates to:
  /// **'Điều trị đích'**
  String get treatmentTargeted;

  /// No description provided for @diagnosisTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán kinh nghiệm'**
  String get diagnosisTitle;

  /// No description provided for @diagnosisStepProgress.
  ///
  /// In vi, this message translates to:
  /// **'Bước {step}/{total} · {title}'**
  String diagnosisStepProgress(int step, int total, String title);

  /// No description provided for @diagnosisBack.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get diagnosisBack;

  /// No description provided for @diagnosisContinue.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get diagnosisContinue;

  /// No description provided for @diagnosisRun.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán'**
  String get diagnosisRun;

  /// No description provided for @diagnosisPersonalInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân'**
  String get diagnosisPersonalInfo;

  /// No description provided for @diagnosisVitalSigns.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ số sinh tồn'**
  String get diagnosisVitalSigns;

  /// No description provided for @diagnosisLabResults.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả xét nghiệm'**
  String get diagnosisLabResults;

  /// No description provided for @diagnosisComorbidities.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh nền & nguy cơ'**
  String get diagnosisComorbidities;

  /// No description provided for @diagnosisAllergy.
  ///
  /// In vi, this message translates to:
  /// **'Dị ứng'**
  String get diagnosisAllergy;

  /// No description provided for @diagnosisAllergyType.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng dị ứng kháng sinh'**
  String get diagnosisAllergyType;

  /// No description provided for @diagnosisAllergyNo.
  ///
  /// In vi, this message translates to:
  /// **'Không dị ứng'**
  String get diagnosisAllergyNo;

  /// No description provided for @diagnosisAllergyYes.
  ///
  /// In vi, this message translates to:
  /// **'Có dị ứng kháng sinh'**
  String get diagnosisAllergyYes;

  /// No description provided for @diagnosisAllergyNonRegistered.
  ///
  /// In vi, this message translates to:
  /// **'Dị ứng kháng sinh ngoài danh mục'**
  String get diagnosisAllergyNonRegistered;

  /// No description provided for @diagnosisAllergyUnknown.
  ///
  /// In vi, this message translates to:
  /// **'Không rõ / dị ứng khác'**
  String get diagnosisAllergyUnknown;

  /// No description provided for @diagnosisAllergySelect.
  ///
  /// In vi, this message translates to:
  /// **'Chọn kháng sinh dị ứng'**
  String get diagnosisAllergySelect;

  /// No description provided for @diagnosisAllergyOther.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả dị ứng khác'**
  String get diagnosisAllergyOther;

  /// No description provided for @diagnosisEmptyForm.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu biểu mẫu.'**
  String get diagnosisEmptyForm;

  /// No description provided for @diagnosisFormLoadFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải biểu mẫu chẩn đoán.'**
  String get diagnosisFormLoadFailed;

  /// No description provided for @diagnosisResultTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả chẩn đoán'**
  String get diagnosisResultTitle;

  /// No description provided for @diagnosisResultSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Kinh nghiệm · Viêm phổi cộng đồng'**
  String get diagnosisResultSubtitle;

  /// No description provided for @diagnosisSaveResult.
  ///
  /// In vi, this message translates to:
  /// **'Lưu kết quả'**
  String get diagnosisSaveResult;

  /// No description provided for @diagnosisTabResult.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả'**
  String get diagnosisTabResult;

  /// No description provided for @diagnosisTabSuspected.
  ///
  /// In vi, this message translates to:
  /// **'Căn nguyên'**
  String get diagnosisTabSuspected;

  /// No description provided for @diagnosisTabEvidences.
  ///
  /// In vi, this message translates to:
  /// **'Bằng chứng'**
  String get diagnosisTabEvidences;

  /// No description provided for @diagnosisSectionDiagnosis.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán'**
  String get diagnosisSectionDiagnosis;

  /// No description provided for @diagnosisCommunityPneumonia.
  ///
  /// In vi, this message translates to:
  /// **'Viêm phổi cộng đồng'**
  String get diagnosisCommunityPneumonia;

  /// No description provided for @diagnosisEmpiricalLabel.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán kinh nghiệm'**
  String get diagnosisEmpiricalLabel;

  /// No description provided for @diagnosisSectionAssessment.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá'**
  String get diagnosisSectionAssessment;

  /// No description provided for @diagnosisSeverity.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ'**
  String get diagnosisSeverity;

  /// No description provided for @diagnosisTreatment.
  ///
  /// In vi, this message translates to:
  /// **'Điều trị'**
  String get diagnosisTreatment;

  /// No description provided for @diagnosisConfirmNote.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả cần được bác sĩ xác nhận trước khi áp dụng điều trị.'**
  String get diagnosisConfirmNote;

  /// No description provided for @suspectedHeavy.
  ///
  /// In vi, this message translates to:
  /// **'Căn nguyên nghi ngờ cao'**
  String get suspectedHeavy;

  /// No description provided for @suspectedWorth.
  ///
  /// In vi, this message translates to:
  /// **'Căn nguyên cần lưu ý'**
  String get suspectedWorth;

  /// No description provided for @evidenceSection.
  ///
  /// In vi, this message translates to:
  /// **'Bằng chứng lâm sàng'**
  String get evidenceSection;

  /// No description provided for @diagnosisNoData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu.'**
  String get diagnosisNoData;

  /// No description provided for @evidencePoints.
  ///
  /// In vi, this message translates to:
  /// **'Điểm {score}'**
  String evidencePoints(int score);

  /// No description provided for @evidenceMajor.
  ///
  /// In vi, this message translates to:
  /// **'Chính'**
  String get evidenceMajor;

  /// No description provided for @evidenceMinor.
  ///
  /// In vi, this message translates to:
  /// **'Phụ'**
  String get evidenceMinor;

  /// No description provided for @severityMild.
  ///
  /// In vi, this message translates to:
  /// **'Nhẹ'**
  String get severityMild;

  /// No description provided for @severityModerate.
  ///
  /// In vi, this message translates to:
  /// **'Trung bình'**
  String get severityModerate;

  /// No description provided for @severitySevere.
  ///
  /// In vi, this message translates to:
  /// **'Nặng'**
  String get severitySevere;

  /// No description provided for @siteInpatient.
  ///
  /// In vi, this message translates to:
  /// **'Nội trú'**
  String get siteInpatient;

  /// No description provided for @siteOutpatient.
  ///
  /// In vi, this message translates to:
  /// **'Ngoại trú'**
  String get siteOutpatient;

  /// No description provided for @siteIcu.
  ///
  /// In vi, this message translates to:
  /// **'ICU'**
  String get siteIcu;

  /// No description provided for @riskHigh.
  ///
  /// In vi, this message translates to:
  /// **'Nguy cơ cao'**
  String get riskHigh;

  /// No description provided for @riskLow.
  ///
  /// In vi, this message translates to:
  /// **'Nguy cơ thấp'**
  String get riskLow;

  /// No description provided for @riskWatch.
  ///
  /// In vi, this message translates to:
  /// **'Cần theo dõi'**
  String get riskWatch;

  /// No description provided for @alertPregnantTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh nhân đang mang thai / cho con bú'**
  String get alertPregnantTitle;

  /// No description provided for @alertPregnantDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cân nhắc kỹ trước khi chỉ định kháng sinh.'**
  String get alertPregnantDesc;

  /// No description provided for @alertMissingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thiếu thông tin cần thiết'**
  String get alertMissingTitle;

  /// No description provided for @targetedTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán vi sinh'**
  String get targetedTitle;

  /// No description provided for @targetedSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Mỗi đường dùng là một lựa chọn thuốc riêng'**
  String get targetedSubtitle;

  /// No description provided for @targetedLoadError.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải khuyến nghị. Vui lòng thử lại.'**
  String get targetedLoadError;

  /// No description provided for @targetedSelectDrugs.
  ///
  /// In vi, this message translates to:
  /// **'Chọn thuốc + đường dùng'**
  String get targetedSelectDrugs;

  /// No description provided for @targetedSelectedSummary.
  ///
  /// In vi, this message translates to:
  /// **'Đã chọn theo thuốc + đường dùng'**
  String get targetedSelectedSummary;

  /// No description provided for @targetedSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu điều trị đích'**
  String get targetedSave;

  /// No description provided for @microBacteria.
  ///
  /// In vi, this message translates to:
  /// **'Vi khuẩn'**
  String get microBacteria;

  /// No description provided for @microLatestAntibiogram.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh đồ gần nhất'**
  String get microLatestAntibiogram;

  /// No description provided for @diagnosisFlowNoPatient.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn bệnh nhân.'**
  String get diagnosisFlowNoPatient;

  /// No description provided for @diagnosisFlowFormError.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải biểu mẫu chẩn đoán.'**
  String get diagnosisFlowFormError;

  /// No description provided for @diagnosisFlowMissing.
  ///
  /// In vi, this message translates to:
  /// **'Thiếu thông tin bắt buộc: {fields}.'**
  String diagnosisFlowMissing(String fields);

  /// No description provided for @diagnosisMedicalHistory.
  ///
  /// In vi, this message translates to:
  /// **'Tiền sử bệnh'**
  String get diagnosisMedicalHistory;

  /// No description provided for @diagnosisSpecialHistory.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh sử đặc biệt'**
  String get diagnosisSpecialHistory;

  /// No description provided for @diagnosisSpecialHistoryHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập bệnh sử mà hệ thống chưa bao phủ'**
  String get diagnosisSpecialHistoryHint;

  /// No description provided for @diagnosisAdd.
  ///
  /// In vi, this message translates to:
  /// **'Thêm'**
  String get diagnosisAdd;

  /// No description provided for @diagnosisRemove.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get diagnosisRemove;

  /// No description provided for @diagnosisOtherInfections.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm trùng khác'**
  String get diagnosisOtherInfections;

  /// No description provided for @diagnosisOtherInfectionsSelect.
  ///
  /// In vi, this message translates to:
  /// **'Chọn nhiễm trùng kèm theo'**
  String get diagnosisOtherInfectionsSelect;

  /// No description provided for @diagnosisMicrobialSamples.
  ///
  /// In vi, this message translates to:
  /// **'Mẫu xét nghiệm vi sinh'**
  String get diagnosisMicrobialSamples;

  /// No description provided for @diagnosisMicrobialAdd.
  ///
  /// In vi, this message translates to:
  /// **'Thêm mẫu'**
  String get diagnosisMicrobialAdd;

  /// No description provided for @diagnosisMicrobialSampleType.
  ///
  /// In vi, this message translates to:
  /// **'Loại mẫu'**
  String get diagnosisMicrobialSampleType;

  /// No description provided for @diagnosisMicrobialMicCategory.
  ///
  /// In vi, this message translates to:
  /// **'Mức MIC'**
  String get diagnosisMicrobialMicCategory;

  /// No description provided for @diagnosisMicrobialPathogen.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân'**
  String get diagnosisMicrobialPathogen;

  /// No description provided for @diagnosisMicrobialPathogenHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tác nhân'**
  String get diagnosisMicrobialPathogenHint;

  /// No description provided for @diagnosisMicrobialPathogenRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn tác nhân cho tất cả mẫu vi sinh.'**
  String get diagnosisMicrobialPathogenRequired;

  /// No description provided for @diagnosisAllergyRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn tình trạng dị ứng kháng sinh.'**
  String get diagnosisAllergyRequired;

  /// No description provided for @diagnosisAllergyYesRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn ít nhất một kháng sinh dị ứng.'**
  String get diagnosisAllergyYesRequired;

  /// No description provided for @diagnosisAllergyOtherRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng mô tả dị ứng khác.'**
  String get diagnosisAllergyOtherRequired;

  /// No description provided for @diagnosisInvalidNumber.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị \"{name}\" phải là số.'**
  String diagnosisInvalidNumber(String name);

  /// No description provided for @diagnosisEgfr.
  ///
  /// In vi, this message translates to:
  /// **'eGFR'**
  String get diagnosisEgfr;

  /// No description provided for @diagnosisOtherInfectionsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm trùng khác'**
  String get diagnosisOtherInfectionsTitle;

  /// No description provided for @diagnosisAllergyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dị ứng kháng sinh'**
  String get diagnosisAllergyTitle;

  /// No description provided for @diagnosisAllergyNoValue.
  ///
  /// In vi, this message translates to:
  /// **'Không có'**
  String get diagnosisAllergyNoValue;

  /// No description provided for @diagnosisSectionMetrics.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết điểm'**
  String get diagnosisSectionMetrics;

  /// No description provided for @diagnosisMetricsMajorMinor.
  ///
  /// In vi, this message translates to:
  /// **'Chính {major} · Phụ {minor}'**
  String diagnosisMetricsMajorMinor(int major, int minor);

  /// No description provided for @diagnosisTabProtocols.
  ///
  /// In vi, this message translates to:
  /// **'Phác đồ'**
  String get diagnosisTabProtocols;

  /// No description provided for @diagnosisSectionProtocols.
  ///
  /// In vi, this message translates to:
  /// **'Phác đồ điều trị'**
  String get diagnosisSectionProtocols;

  /// No description provided for @diagnosisProtocolMedicines.
  ///
  /// In vi, this message translates to:
  /// **'Tổ hợp thuốc'**
  String get diagnosisProtocolMedicines;

  /// No description provided for @diagnosisProtocolPathogens.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân'**
  String get diagnosisProtocolPathogens;

  /// No description provided for @diagnosisProtocolCriteria.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí'**
  String get diagnosisProtocolCriteria;

  /// No description provided for @diagnosisProtocolNoData.
  ///
  /// In vi, this message translates to:
  /// **'Không có phác đồ phù hợp.'**
  String get diagnosisProtocolNoData;

  /// No description provided for @diagnosisProtocolSelect.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tổ hợp thuốc'**
  String get diagnosisProtocolSelect;

  /// No description provided for @diagnosisProtocolNoMedicine.
  ///
  /// In vi, this message translates to:
  /// **'Không có tổ hợp thuốc.'**
  String get diagnosisProtocolNoMedicine;

  /// No description provided for @diagnosisConfirmTreatment.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận điều trị'**
  String get diagnosisConfirmTreatment;

  /// No description provided for @diagnosisReason.
  ///
  /// In vi, this message translates to:
  /// **'Lý do chọn thuốc'**
  String get diagnosisReason;

  /// No description provided for @diagnosisReasonHint.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc nếu chọn thuốc ngoài phác đồ'**
  String get diagnosisReasonHint;

  /// No description provided for @diagnosisWarnCombinationTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cảnh báo phối hợp kháng sinh'**
  String get diagnosisWarnCombinationTitle;

  /// No description provided for @diagnosisWarnCombinationDesc.
  ///
  /// In vi, this message translates to:
  /// **'Tổ hợp thuốc đã chọn cần được kiểm tra trước khi chỉ định.'**
  String get diagnosisWarnCombinationDesc;

  /// No description provided for @diagnosisConfirmSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu kết quả điều trị.'**
  String get diagnosisConfirmSuccess;

  /// No description provided for @diagnosisConfirmFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lưu kết quả điều trị.'**
  String get diagnosisConfirmFailed;

  /// No description provided for @diagnosisConfirmMissingResult.
  ///
  /// In vi, this message translates to:
  /// **'Không có kết quả chẩn đoán để lưu.'**
  String get diagnosisConfirmMissingResult;

  /// No description provided for @diagnosisSelectMedicineRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn tổ hợp thuốc.'**
  String get diagnosisSelectMedicineRequired;

  /// No description provided for @diagnosisNoProtocolToSave.
  ///
  /// In vi, this message translates to:
  /// **'Không có phác đồ phù hợp để lưu.'**
  String get diagnosisNoProtocolToSave;

  /// No description provided for @diagnosisEvidenceFormula.
  ///
  /// In vi, this message translates to:
  /// **'Công thức: {formula}'**
  String diagnosisEvidenceFormula(String formula);

  /// No description provided for @diagnosisEvidenceValue.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị: {value}'**
  String diagnosisEvidenceValue(String value);

  /// No description provided for @diagnosisEvidenceRelated.
  ///
  /// In vi, this message translates to:
  /// **'Biến liên quan: {variables}'**
  String diagnosisEvidenceRelated(String variables);

  /// No description provided for @diagnosisEvidenceMissing.
  ///
  /// In vi, this message translates to:
  /// **'Thiếu: {variables}'**
  String diagnosisEvidenceMissing(String variables);

  /// No description provided for @diagnosisMicrobialResultTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả vi sinh'**
  String get diagnosisMicrobialResultTitle;

  /// No description provided for @diagnosisMicrobialAntibiotics.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh nhạy cảm'**
  String get diagnosisMicrobialAntibiotics;

  /// No description provided for @diagnosisDiagnosisId.
  ///
  /// In vi, this message translates to:
  /// **'Mã chẩn đoán'**
  String get diagnosisDiagnosisId;

  /// No description provided for @infectionSkinSoftTissue.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm khuẩn da / mô mềm'**
  String get infectionSkinSoftTissue;

  /// No description provided for @infectionSepticArthritis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm khớp nhiễm khuẩn'**
  String get infectionSepticArthritis;

  /// No description provided for @infectionOsteomyelitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm tủy xương nhiễm khuẩn'**
  String get infectionOsteomyelitis;

  /// No description provided for @infectionBacterialMyositis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm cơ / áp xe cơ nhiễm khuẩn'**
  String get infectionBacterialMyositis;

  /// No description provided for @infectionInfectedGoutyTophus.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm khuẩn hạt tophi'**
  String get infectionInfectedGoutyTophus;

  /// No description provided for @infectionPyelonephritis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm / áp xe thận - bể thận'**
  String get infectionPyelonephritis;

  /// No description provided for @infectionAcuteCystitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm bàng quang cấp'**
  String get infectionAcuteCystitis;

  /// No description provided for @infectionAcuteNonGonococcalUrethritis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm niệu đạo cấp không do lậu'**
  String get infectionAcuteNonGonococcalUrethritis;

  /// No description provided for @infectionBacterialVaginourethritis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm âm đạo - niệu đạo do vi khuẩn'**
  String get infectionBacterialVaginourethritis;

  /// No description provided for @infectionBacterialEndometritis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm tử cung do vi khuẩn'**
  String get infectionBacterialEndometritis;

  /// No description provided for @infectionPurulentMeningitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm màng não mủ'**
  String get infectionPurulentMeningitis;

  /// No description provided for @infectionBacterialEncephalitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm não do vi khuẩn'**
  String get infectionBacterialEncephalitis;

  /// No description provided for @infectionPleuralEmpyema.
  ///
  /// In vi, this message translates to:
  /// **'Tràn mủ màng phổi'**
  String get infectionPleuralEmpyema;

  /// No description provided for @infectionMediastinalAbscess.
  ///
  /// In vi, this message translates to:
  /// **'Áp xe trung thất'**
  String get infectionMediastinalAbscess;

  /// No description provided for @infectionInfectiveEndocarditis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm nội tâm mạc nhiễm khuẩn'**
  String get infectionInfectiveEndocarditis;

  /// No description provided for @infectionBacterialMyocarditis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm cơ tim do vi khuẩn'**
  String get infectionBacterialMyocarditis;

  /// No description provided for @infectionBacterialPericarditis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm màng ngoài tim do vi khuẩn'**
  String get infectionBacterialPericarditis;

  /// No description provided for @infectionPulmonaryTuberculosis.
  ///
  /// In vi, this message translates to:
  /// **'Lao phổi'**
  String get infectionPulmonaryTuberculosis;

  /// No description provided for @infectionExtrapulmonaryTuberculosis.
  ///
  /// In vi, this message translates to:
  /// **'Lao ngoài phổi'**
  String get infectionExtrapulmonaryTuberculosis;

  /// No description provided for @infectionBiliaryTract.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm trùng đường mật'**
  String get infectionBiliaryTract;

  /// No description provided for @infectionBacterialLiverAbscess.
  ///
  /// In vi, this message translates to:
  /// **'Áp xe gan do vi khuẩn'**
  String get infectionBacterialLiverAbscess;

  /// No description provided for @infectionInfectedAcutePancreatitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm tụy cấp nhiễm khuẩn'**
  String get infectionInfectedAcutePancreatitis;

  /// No description provided for @infectionBacterialPeritonitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm phúc mạc nhiễm khuẩn'**
  String get infectionBacterialPeritonitis;

  /// No description provided for @infectionBacterialDiarrhea.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chảy do vi khuẩn'**
  String get infectionBacterialDiarrhea;

  /// No description provided for @infectionHelicobacterPylori.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm Helicobacter pylori'**
  String get infectionHelicobacterPylori;

  /// No description provided for @infectionSepsis.
  ///
  /// In vi, this message translates to:
  /// **'Nhiễm trùng huyết'**
  String get infectionSepsis;

  /// No description provided for @infectionOrbitalCellulitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm tổ chức hốc mắt'**
  String get infectionOrbitalCellulitis;

  /// No description provided for @infectionConjunctivitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm kết mạc mắt'**
  String get infectionConjunctivitis;

  /// No description provided for @infectionKeratitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm giác mạc mắt'**
  String get infectionKeratitis;

  /// No description provided for @infectionDacryocystitis.
  ///
  /// In vi, this message translates to:
  /// **'Viêm túi lệ mắt'**
  String get infectionDacryocystitis;

  /// No description provided for @infectionMaxillofacialAbscess.
  ///
  /// In vi, this message translates to:
  /// **'Áp xe vùng hàm - mặt'**
  String get infectionMaxillofacialAbscess;

  /// No description provided for @infectionOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get infectionOther;

  /// No description provided for @sampleSputum.
  ///
  /// In vi, this message translates to:
  /// **'Đờm'**
  String get sampleSputum;

  /// No description provided for @sampleBronchoalveolarLavageFluid.
  ///
  /// In vi, this message translates to:
  /// **'Dịch rửa phế quản / phế nang'**
  String get sampleBronchoalveolarLavageFluid;

  /// No description provided for @samplePleuralFluid.
  ///
  /// In vi, this message translates to:
  /// **'Dịch màng phổi'**
  String get samplePleuralFluid;

  /// No description provided for @sampleUrine.
  ///
  /// In vi, this message translates to:
  /// **'Nước tiểu'**
  String get sampleUrine;

  /// No description provided for @sampleBlood.
  ///
  /// In vi, this message translates to:
  /// **'Máu'**
  String get sampleBlood;

  /// No description provided for @sampleAbdominalFluid.
  ///
  /// In vi, this message translates to:
  /// **'Dịch ổ bụng'**
  String get sampleAbdominalFluid;

  /// No description provided for @sampleCerebrospinalFluid.
  ///
  /// In vi, this message translates to:
  /// **'Dịch não tủy'**
  String get sampleCerebrospinalFluid;

  /// No description provided for @sampleWoundExudate.
  ///
  /// In vi, this message translates to:
  /// **'Dịch tiết vết thương'**
  String get sampleWoundExudate;

  /// No description provided for @sampleOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get sampleOther;

  /// No description provided for @micSusceptible.
  ///
  /// In vi, this message translates to:
  /// **'Nhạy cảm'**
  String get micSusceptible;

  /// No description provided for @micIntermediate.
  ///
  /// In vi, this message translates to:
  /// **'Trung gian'**
  String get micIntermediate;

  /// No description provided for @micResistant.
  ///
  /// In vi, this message translates to:
  /// **'Kháng'**
  String get micResistant;

  /// No description provided for @routeIntravenous.
  ///
  /// In vi, this message translates to:
  /// **'Tiêm tĩnh mạch'**
  String get routeIntravenous;

  /// No description provided for @routeOral.
  ///
  /// In vi, this message translates to:
  /// **'Uống'**
  String get routeOral;

  /// No description provided for @routeIntramuscular.
  ///
  /// In vi, this message translates to:
  /// **'Tiêm bắp'**
  String get routeIntramuscular;

  /// No description provided for @routeAbbrevIv.
  ///
  /// In vi, this message translates to:
  /// **'TM'**
  String get routeAbbrevIv;

  /// No description provided for @routeAbbrevOral.
  ///
  /// In vi, this message translates to:
  /// **'Uống'**
  String get routeAbbrevOral;

  /// No description provided for @calculatorTitle.
  ///
  /// In vi, this message translates to:
  /// **'Máy tính'**
  String get calculatorTitle;

  /// No description provided for @calculatorSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Công cụ tính lâm sàng'**
  String get calculatorSubtitle;

  /// No description provided for @calculatorCommonTools.
  ///
  /// In vi, this message translates to:
  /// **'Công cụ thường dùng'**
  String get calculatorCommonTools;

  /// No description provided for @calculatorComingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Máy tính \"{title}\" sẽ được bổ sung sau.'**
  String calculatorComingSoon(String title);

  /// No description provided for @calcCurb65Desc.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá mức độ nặng viêm phổi'**
  String get calcCurb65Desc;

  /// No description provided for @calcEgfrDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ước tính chức năng thận'**
  String get calcEgfrDesc;

  /// No description provided for @calcCrclDesc.
  ///
  /// In vi, this message translates to:
  /// **'Độ thanh thải creatinin'**
  String get calcCrclDesc;

  /// No description provided for @calcBmiDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ số khối cơ thể'**
  String get calcBmiDesc;

  /// No description provided for @calcQsofaDesc.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá nhanh nguy cơ nhiễm khuẩn'**
  String get calcQsofaDesc;

  /// No description provided for @calcClinicalCalculator.
  ///
  /// In vi, this message translates to:
  /// **'Máy tính lâm sàng'**
  String get calcClinicalCalculator;

  /// No description provided for @calcInputTab.
  ///
  /// In vi, this message translates to:
  /// **'Nhập liệu'**
  String get calcInputTab;

  /// No description provided for @calcExplanationTab.
  ///
  /// In vi, this message translates to:
  /// **'Giải thích'**
  String get calcExplanationTab;

  /// No description provided for @calcCriteriaBanner.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí CURB-65'**
  String get calcCriteriaBanner;

  /// No description provided for @calcConfusion.
  ///
  /// In vi, this message translates to:
  /// **'Lú lẫn mới xuất hiện'**
  String get calcConfusion;

  /// No description provided for @calcConfusionDesc.
  ///
  /// In vi, this message translates to:
  /// **'Confusion'**
  String get calcConfusionDesc;

  /// No description provided for @calcUrea.
  ///
  /// In vi, this message translates to:
  /// **'Urea'**
  String get calcUrea;

  /// No description provided for @calcUreaDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ngưỡng > 7 mmol/L'**
  String get calcUreaDesc;

  /// No description provided for @calcRespRate.
  ///
  /// In vi, this message translates to:
  /// **'Nhịp thở'**
  String get calcRespRate;

  /// No description provided for @calcRespRateDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ngưỡng ≥ 30 lần/phút'**
  String get calcRespRateDesc;

  /// No description provided for @calcRespRateUnit.
  ///
  /// In vi, this message translates to:
  /// **'lần/phút'**
  String get calcRespRateUnit;

  /// No description provided for @calcBloodPressure.
  ///
  /// In vi, this message translates to:
  /// **'Huyết áp'**
  String get calcBloodPressure;

  /// No description provided for @calcBpThreshold.
  ///
  /// In vi, this message translates to:
  /// **'Ngưỡng: SBP < 90 mmHg hoặc DBP ≤ 60 mmHg'**
  String get calcBpThreshold;

  /// No description provided for @calcAge.
  ///
  /// In vi, this message translates to:
  /// **'Tuổi'**
  String get calcAge;

  /// No description provided for @calcAgeDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ngưỡng ≥ 65 tuổi'**
  String get calcAgeDesc;

  /// No description provided for @calcAgeUnit.
  ///
  /// In vi, this message translates to:
  /// **'tuổi'**
  String get calcAgeUnit;

  /// No description provided for @calcCalculate.
  ///
  /// In vi, this message translates to:
  /// **'Tính'**
  String get calcCalculate;

  /// No description provided for @calcMethodTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phương pháp tính'**
  String get calcMethodTitle;

  /// No description provided for @calcMethodBody.
  ///
  /// In vi, this message translates to:
  /// **'Điểm CURB-65 = tổng số tiêu chí được đáp ứng, từ 0 đến 5 điểm. Mỗi tiêu chí đáp ứng đóng góp 1 điểm.'**
  String get calcMethodBody;

  /// No description provided for @calcDescriptionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get calcDescriptionTitle;

  /// No description provided for @calcDescriptionBody.
  ///
  /// In vi, this message translates to:
  /// **'CURB-65 hỗ trợ đánh giá mức độ nặng của viêm phổi cộng đồng.'**
  String get calcDescriptionBody;

  /// No description provided for @calcConfirmNote.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả cần được bác sĩ xác nhận trong bối cảnh lâm sàng.'**
  String get calcConfirmNote;

  /// No description provided for @calcComponentsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Các thành phần'**
  String get calcComponentsTitle;

  /// No description provided for @calcComponentsBody.
  ///
  /// In vi, this message translates to:
  /// **'Lú lẫn · Urea > 7 mmol/L · Nhịp thở ≥ 30 · Huyết áp thấp · Tuổi ≥ 65.'**
  String get calcComponentsBody;

  /// No description provided for @calcThresholdNote.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết ngưỡng được hiển thị tại tab Nhập liệu.'**
  String get calcThresholdNote;

  /// No description provided for @calcScorePoints.
  ///
  /// In vi, this message translates to:
  /// **'{score} điểm'**
  String calcScorePoints(int score);

  /// No description provided for @calcAdviceHigh.
  ///
  /// In vi, this message translates to:
  /// **'Điểm {score} → cân nhắc điều trị nội trú'**
  String calcAdviceHigh(int score);

  /// No description provided for @calcAdviceMedium.
  ///
  /// In vi, this message translates to:
  /// **'Điểm {score} → cân nhắc nhập viện ngắn hạn'**
  String calcAdviceMedium(int score);

  /// No description provided for @calcAdviceLow.
  ///
  /// In vi, this message translates to:
  /// **'Điểm {score} → có thể điều trị ngoại trú'**
  String calcAdviceLow(int score);

  /// No description provided for @lookupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tra cứu'**
  String get lookupTitle;

  /// No description provided for @lookupSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tài liệu y tế dành cho bác sĩ'**
  String get lookupSubtitle;

  /// No description provided for @lookupCategories.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get lookupCategories;

  /// No description provided for @lookupSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm thuốc, vi khuẩn, bệnh lý...'**
  String get lookupSearchHint;

  /// No description provided for @categoryAntibioticGroups.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm kháng sinh'**
  String get categoryAntibioticGroups;

  /// No description provided for @categoryAntibioticGroupsSub.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại và mô tả'**
  String get categoryAntibioticGroupsSub;

  /// No description provided for @categoryAntibiotics.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh'**
  String get categoryAntibiotics;

  /// No description provided for @categoryAntibioticsSub.
  ///
  /// In vi, this message translates to:
  /// **'Liều dùng và phổ tác dụng'**
  String get categoryAntibioticsSub;

  /// No description provided for @categoryPathogens.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân gây bệnh'**
  String get categoryPathogens;

  /// No description provided for @categoryPathogensSub.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả và độ nhạy'**
  String get categoryPathogensSub;

  /// No description provided for @categoryClinicalVariables.
  ///
  /// In vi, this message translates to:
  /// **'Biến số lâm sàng'**
  String get categoryClinicalVariables;

  /// No description provided for @categoryClinicalVariablesSub.
  ///
  /// In vi, this message translates to:
  /// **'Các biến số dùng cho tiêu chí'**
  String get categoryClinicalVariablesSub;

  /// No description provided for @categorySuspectedCauses.
  ///
  /// In vi, this message translates to:
  /// **'Nguyên nhân nghi ngờ'**
  String get categorySuspectedCauses;

  /// No description provided for @categorySuspectedCausesSub.
  ///
  /// In vi, this message translates to:
  /// **'Theo bệnh và mức độ'**
  String get categorySuspectedCausesSub;

  /// No description provided for @categoryCriteria.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí đánh giá'**
  String get categoryCriteria;

  /// No description provided for @categoryCriteriaSub.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách các tiêu chí'**
  String get categoryCriteriaSub;

  /// No description provided for @categoryRiskFactors.
  ///
  /// In vi, this message translates to:
  /// **'Yếu tố nguy cơ'**
  String get categoryRiskFactors;

  /// No description provided for @categoryRiskFactorsSub.
  ///
  /// In vi, this message translates to:
  /// **'Nguy cơ theo tác nhân'**
  String get categoryRiskFactorsSub;

  /// No description provided for @categoryClinicalScores.
  ///
  /// In vi, this message translates to:
  /// **'Thang điểm lâm sàng'**
  String get categoryClinicalScores;

  /// No description provided for @categoryClinicalScoresSub.
  ///
  /// In vi, this message translates to:
  /// **'Các bộ tiêu chí & đánh giá'**
  String get categoryClinicalScoresSub;

  /// No description provided for @categoryAntibiograms.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh đồ'**
  String get categoryAntibiograms;

  /// No description provided for @categoryAntibiogramsSub.
  ///
  /// In vi, this message translates to:
  /// **'MIC và kháng sinh'**
  String get categoryAntibiogramsSub;

  /// No description provided for @categoryTreatmentProtocols.
  ///
  /// In vi, this message translates to:
  /// **'Phác đồ điều trị'**
  String get categoryTreatmentProtocols;

  /// No description provided for @categoryTreatmentProtocolsSub.
  ///
  /// In vi, this message translates to:
  /// **'Theo mức độ & vị trí'**
  String get categoryTreatmentProtocolsSub;

  /// No description provided for @recentItemDrugTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ceftriaxone'**
  String get recentItemDrugTitle;

  /// No description provided for @recentItemDrugSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Cephalosporin thế hệ 3'**
  String get recentItemDrugSubtitle;

  /// No description provided for @recentItemDrugTag.
  ///
  /// In vi, this message translates to:
  /// **'Thuốc'**
  String get recentItemDrugTag;

  /// No description provided for @recentItemDiseaseTitle.
  ///
  /// In vi, this message translates to:
  /// **'Viêm phổi cộng đồng'**
  String get recentItemDiseaseTitle;

  /// No description provided for @recentItemDiseaseSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'5 tiêu chí đánh giá'**
  String get recentItemDiseaseSubtitle;

  /// No description provided for @recentItemDiseaseTag.
  ///
  /// In vi, this message translates to:
  /// **'Bệnh'**
  String get recentItemDiseaseTag;

  /// No description provided for @statisticsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get statisticsTitle;

  /// No description provided for @statisticsSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tổng quan hoạt động điều trị'**
  String get statisticsSubtitle;

  /// No description provided for @statisticsWeekly.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán theo tuần'**
  String get statisticsWeekly;

  /// No description provided for @statisticsTopPathogens.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân thường gặp'**
  String get statisticsTopPathogens;

  /// No description provided for @statisticsSynced.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu đã đồng bộ'**
  String get statisticsSynced;

  /// No description provided for @statisticsUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật lúc 19:28 hôm nay'**
  String get statisticsUpdated;

  /// No description provided for @periodLast30Days.
  ///
  /// In vi, this message translates to:
  /// **'30 ngày'**
  String get periodLast30Days;

  /// No description provided for @periodThisQuarter.
  ///
  /// In vi, this message translates to:
  /// **'Quý này'**
  String get periodThisQuarter;

  /// No description provided for @periodThisYear.
  ///
  /// In vi, this message translates to:
  /// **'Năm nay'**
  String get periodThisYear;

  /// No description provided for @kpiDiagnoses.
  ///
  /// In vi, this message translates to:
  /// **'Chẩn đoán'**
  String get kpiDiagnoses;

  /// No description provided for @kpiSaved.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu'**
  String get kpiSaved;

  /// No description provided for @kpiMicrobiology.
  ///
  /// In vi, this message translates to:
  /// **'Vi sinh'**
  String get kpiMicrobiology;

  /// No description provided for @statisticsWeek.
  ///
  /// In vi, this message translates to:
  /// **'T{week}'**
  String statisticsWeek(int week);

  /// No description provided for @antibioticTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh'**
  String get antibioticTitle;

  /// No description provided for @antibioticSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục hoạt chất'**
  String get antibioticSubtitle;

  /// No description provided for @antibioticSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm kháng sinh...'**
  String get antibioticSearchHint;

  /// No description provided for @antibioticEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu kháng sinh'**
  String get antibioticEmpty;

  /// No description provided for @antibioticDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin kháng sinh'**
  String get antibioticDetailSubtitle;

  /// No description provided for @antibioticDosage.
  ///
  /// In vi, this message translates to:
  /// **'Liều dùng'**
  String get antibioticDosage;

  /// No description provided for @antibioticStandardDose.
  ///
  /// In vi, this message translates to:
  /// **'Liều chuẩn'**
  String get antibioticStandardDose;

  /// No description provided for @antibioticNoInfo.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có thông tin'**
  String get antibioticNoInfo;

  /// No description provided for @antibioticGfrAdjust.
  ///
  /// In vi, this message translates to:
  /// **'Điều chỉnh theo GFR'**
  String get antibioticGfrAdjust;

  /// No description provided for @antibioticGroupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm kháng sinh'**
  String get antibioticGroupTitle;

  /// No description provided for @antibioticGroupSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại và mô tả'**
  String get antibioticGroupSubtitle;

  /// No description provided for @antibioticGroupSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm nhóm...'**
  String get antibioticGroupSearchHint;

  /// No description provided for @antibioticGroupDetailWithParent.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm kháng sinh · {parent}'**
  String antibioticGroupDetailWithParent(String parent);

  /// No description provided for @antibioticGroupDetail.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm kháng sinh'**
  String get antibioticGroupDetail;

  /// No description provided for @antibioticGroupInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin nhóm'**
  String get antibioticGroupInfo;

  /// No description provided for @antibioticGroupParent.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm cha'**
  String get antibioticGroupParent;

  /// No description provided for @antibioticGroupDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get antibioticGroupDescription;

  /// No description provided for @antibioticGroupNone.
  ///
  /// In vi, this message translates to:
  /// **'Không có'**
  String get antibioticGroupNone;

  /// No description provided for @antibioticGroupNoData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get antibioticGroupNoData;

  /// No description provided for @antibioticGroupAntibioticsInGroup.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh trong nhóm'**
  String get antibioticGroupAntibioticsInGroup;

  /// No description provided for @antibioticGroupLoadError.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được dữ liệu'**
  String get antibioticGroupLoadError;

  /// No description provided for @antibioticGroupEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có kháng sinh nào trong nhóm này'**
  String get antibioticGroupEmpty;

  /// No description provided for @antibioticGroupClassification.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại: {classification}'**
  String antibioticGroupClassification(String classification);

  /// No description provided for @pathogenTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân gây bệnh'**
  String get pathogenTitle;

  /// No description provided for @pathogenSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả và độ nhạy'**
  String get pathogenSubtitle;

  /// No description provided for @pathogenSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tác nhân...'**
  String get pathogenSearchHint;

  /// No description provided for @pathogenAtypical.
  ///
  /// In vi, this message translates to:
  /// **'Không điển hình'**
  String get pathogenAtypical;

  /// No description provided for @pathogenDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get pathogenDescription;

  /// No description provided for @antibiogramTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh đồ'**
  String get antibiogramTitle;

  /// No description provided for @antibiogramSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân · MIC · kháng sinh'**
  String get antibiogramSubtitle;

  /// No description provided for @antibiogramSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm tác nhân hoặc kháng sinh...'**
  String get antibiogramSearchHint;

  /// No description provided for @antibiogramEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có dữ liệu kháng sinh đồ.'**
  String get antibiogramEmpty;

  /// No description provided for @antibiogramAntibiotics.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh ({count})'**
  String antibiogramAntibiotics(int count);

  /// No description provided for @treatmentProtocolTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phác đồ điều trị'**
  String get treatmentProtocolTitle;

  /// No description provided for @treatmentProtocolSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ · vị trí · kháng sinh'**
  String get treatmentProtocolSubtitle;

  /// No description provided for @treatmentProtocolSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm tác nhân, tiêu chí, kháng sinh...'**
  String get treatmentProtocolSearchHint;

  /// No description provided for @treatmentProtocolEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có phác đồ điều trị.'**
  String get treatmentProtocolEmpty;

  /// No description provided for @treatmentProtocolApplied.
  ///
  /// In vi, this message translates to:
  /// **'Đang áp dụng'**
  String get treatmentProtocolApplied;

  /// No description provided for @treatmentProtocolNotApplied.
  ///
  /// In vi, this message translates to:
  /// **'Ngừng áp dụng'**
  String get treatmentProtocolNotApplied;

  /// No description provided for @treatmentProtocolCriteria.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí'**
  String get treatmentProtocolCriteria;

  /// No description provided for @treatmentProtocolPathogens.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân'**
  String get treatmentProtocolPathogens;

  /// No description provided for @treatmentProtocolCombinations.
  ///
  /// In vi, this message translates to:
  /// **'Tổ hợp kháng sinh'**
  String get treatmentProtocolCombinations;

  /// No description provided for @treatmentProtocolPublisher.
  ///
  /// In vi, this message translates to:
  /// **'Nhà phát hành'**
  String get treatmentProtocolPublisher;

  /// No description provided for @analysisTitle.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo phân tích'**
  String get analysisTitle;

  /// No description provided for @analysisSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tuân thủ & kết cục điều trị'**
  String get analysisSubtitle;

  /// No description provided for @analysisEntryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo phân tích điều trị'**
  String get analysisEntryTitle;

  /// No description provided for @analysisEntrySubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tuân thủ & kết cục theo bác sĩ'**
  String get analysisEntrySubtitle;

  /// No description provided for @analysisEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có báo cáo phân tích.'**
  String get analysisEmpty;

  /// No description provided for @analysisLoadFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải báo cáo phân tích.'**
  String get analysisLoadFailed;

  /// No description provided for @analysisDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết báo cáo'**
  String get analysisDetailTitle;

  /// No description provided for @analysisDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ số tuân thủ & kết cục'**
  String get analysisDetailSubtitle;

  /// No description provided for @analysisPeriod.
  ///
  /// In vi, this message translates to:
  /// **'Kỳ phân tích'**
  String get analysisPeriod;

  /// No description provided for @analysisCreatedAt.
  ///
  /// In vi, this message translates to:
  /// **'Tạo lúc {date}'**
  String analysisCreatedAt(String date);

  /// No description provided for @analysisAllDoctors.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả bác sĩ'**
  String get analysisAllDoctors;

  /// No description provided for @analysisDoctorFallback.
  ///
  /// In vi, this message translates to:
  /// **'Bác sĩ #{id}'**
  String analysisDoctorFallback(String id);

  /// No description provided for @analysisTotalPatients.
  ///
  /// In vi, this message translates to:
  /// **'Tổng bệnh nhân'**
  String get analysisTotalPatients;

  /// No description provided for @analysisTotalPlans.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phác đồ'**
  String get analysisTotalPlans;

  /// No description provided for @analysisAdherenceRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỷ lệ tuân thủ'**
  String get analysisAdherenceRate;

  /// No description provided for @analysisPendingRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỷ lệ chờ đánh giá'**
  String get analysisPendingRate;

  /// No description provided for @analysisAdherent.
  ///
  /// In vi, this message translates to:
  /// **'Tuân thủ'**
  String get analysisAdherent;

  /// No description provided for @analysisNonAdherent.
  ///
  /// In vi, this message translates to:
  /// **'Không tuân thủ'**
  String get analysisNonAdherent;

  /// No description provided for @analysisPendingReview.
  ///
  /// In vi, this message translates to:
  /// **'Chờ đánh giá'**
  String get analysisPendingReview;

  /// No description provided for @analysisOutcomes.
  ///
  /// In vi, this message translates to:
  /// **'Kết cục điều trị'**
  String get analysisOutcomes;

  /// No description provided for @analysisRecovered.
  ///
  /// In vi, this message translates to:
  /// **'Hồi phục'**
  String get analysisRecovered;

  /// No description provided for @analysisDeceased.
  ///
  /// In vi, this message translates to:
  /// **'Tử vong'**
  String get analysisDeceased;

  /// No description provided for @analysisOtherOutcome.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get analysisOtherOutcome;

  /// No description provided for @analysisByDoctor.
  ///
  /// In vi, this message translates to:
  /// **'Theo bác sĩ'**
  String get analysisByDoctor;

  /// No description provided for @analysisByMedicine.
  ///
  /// In vi, this message translates to:
  /// **'Theo thuốc'**
  String get analysisByMedicine;

  /// No description provided for @analysisMedicine.
  ///
  /// In vi, this message translates to:
  /// **'Thuốc'**
  String get analysisMedicine;

  /// No description provided for @analysisClassification.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại'**
  String get analysisClassification;

  /// No description provided for @analysisPatientsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} bệnh nhân'**
  String analysisPatientsCount(int count);

  /// No description provided for @analysisPlansCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} phác đồ'**
  String analysisPlansCount(int count);

  /// No description provided for @analysisNoDoctors.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo không có dữ liệu bác sĩ.'**
  String get analysisNoDoctors;

  /// No description provided for @analysisNoMedicines.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo không có dữ liệu thuốc.'**
  String get analysisNoMedicines;

  /// No description provided for @analysisNoData.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có dữ liệu.'**
  String get analysisNoData;

  /// No description provided for @nextOfKinSection.
  ///
  /// In vi, this message translates to:
  /// **'Người thân liên hệ'**
  String get nextOfKinSection;

  /// No description provided for @nextOfKinEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có thông tin người thân'**
  String get nextOfKinEmpty;

  /// No description provided for @nextOfKinEmptyDesc.
  ///
  /// In vi, this message translates to:
  /// **'Thêm người thân để lưu thông tin liên hệ khi cần thiết.'**
  String get nextOfKinEmptyDesc;

  /// No description provided for @nextOfKinAdd.
  ///
  /// In vi, this message translates to:
  /// **'Thêm người thân'**
  String get nextOfKinAdd;

  /// No description provided for @nextOfKinAddTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm người thân'**
  String get nextOfKinAddTitle;

  /// No description provided for @nextOfKinEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa người thân'**
  String get nextOfKinEditTitle;

  /// No description provided for @nextOfKinSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin liên hệ của bệnh nhân'**
  String get nextOfKinSubtitle;

  /// No description provided for @nextOfKinInfoSection.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin người thân'**
  String get nextOfKinInfoSection;

  /// No description provided for @nextOfKinFullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get nextOfKinFullName;

  /// No description provided for @nextOfKinFullNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên'**
  String get nextOfKinFullNameHint;

  /// No description provided for @nextOfKinRelationship.
  ///
  /// In vi, this message translates to:
  /// **'Mối quan hệ'**
  String get nextOfKinRelationship;

  /// No description provided for @nextOfKinRelationshipHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mối quan hệ'**
  String get nextOfKinRelationshipHint;

  /// No description provided for @nextOfKinPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get nextOfKinPhone;

  /// No description provided for @nextOfKinPhoneHint.
  ///
  /// In vi, this message translates to:
  /// **'0912 345 678'**
  String get nextOfKinPhoneHint;

  /// No description provided for @nextOfKinSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu người thân'**
  String get nextOfKinSave;

  /// No description provided for @nextOfKinUpdate.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get nextOfKinUpdate;

  /// No description provided for @nextOfKinMenuSemantic.
  ///
  /// In vi, this message translates to:
  /// **'Tùy chọn người thân'**
  String get nextOfKinMenuSemantic;

  /// No description provided for @nextOfKinMenuEdit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get nextOfKinMenuEdit;

  /// No description provided for @nextOfKinMenuDelete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get nextOfKinMenuDelete;

  /// No description provided for @nextOfKinDeleteTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa người thân?'**
  String get nextOfKinDeleteTitle;

  /// No description provided for @nextOfKinDeleteDesc.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa thông tin người thân khỏi hồ sơ bệnh nhân không? Hành động này không thể hoàn tác.'**
  String get nextOfKinDeleteDesc;

  /// No description provided for @nextOfKinDeleteConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Xóa người thân'**
  String get nextOfKinDeleteConfirm;

  /// No description provided for @nextOfKinDeleteSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa người thân.'**
  String get nextOfKinDeleteSuccess;

  /// No description provided for @nextOfKinDeleteFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể xóa người thân.'**
  String get nextOfKinDeleteFailed;

  /// No description provided for @nextOfKinCreateSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã thêm người thân.'**
  String get nextOfKinCreateSuccess;

  /// No description provided for @nextOfKinCreateFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể thêm người thân.'**
  String get nextOfKinCreateFailed;

  /// No description provided for @nextOfKinUpdateSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã cập nhật người thân.'**
  String get nextOfKinUpdateSuccess;

  /// No description provided for @nextOfKinUpdateFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể cập nhật người thân.'**
  String get nextOfKinUpdateFailed;

  /// No description provided for @nextOfKinErrName.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập họ và tên người thân.'**
  String get nextOfKinErrName;

  /// No description provided for @nextOfKinErrPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ.'**
  String get nextOfKinErrPhone;

  /// No description provided for @nextOfKinErrRelationship.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn mối quan hệ.'**
  String get nextOfKinErrRelationship;

  /// No description provided for @nextOfKinRelationshipOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get nextOfKinRelationshipOther;

  /// No description provided for @nextOfKinRelationshipOtherHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mối quan hệ'**
  String get nextOfKinRelationshipOtherHint;

  /// No description provided for @relationshipSpouse.
  ///
  /// In vi, this message translates to:
  /// **'Vợ/Chồng'**
  String get relationshipSpouse;

  /// No description provided for @relationshipParent.
  ///
  /// In vi, this message translates to:
  /// **'Cha/Mẹ'**
  String get relationshipParent;

  /// No description provided for @relationshipChild.
  ///
  /// In vi, this message translates to:
  /// **'Con'**
  String get relationshipChild;

  /// No description provided for @relationshipSibling.
  ///
  /// In vi, this message translates to:
  /// **'Anh/Chị/Em'**
  String get relationshipSibling;

  /// No description provided for @relationshipGrandparent.
  ///
  /// In vi, this message translates to:
  /// **'Ông/Bà'**
  String get relationshipGrandparent;

  /// No description provided for @treatmentPlanDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết phác đồ'**
  String get treatmentPlanDetailTitle;

  /// No description provided for @treatmentPlanDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin điều trị đã lưu'**
  String get treatmentPlanDetailSubtitle;

  /// No description provided for @treatmentPlanLoadFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải phác đồ điều trị.'**
  String get treatmentPlanLoadFailed;

  /// No description provided for @treatmentPlanStatusInProgress.
  ///
  /// In vi, this message translates to:
  /// **'Đang điều trị'**
  String get treatmentPlanStatusInProgress;

  /// No description provided for @treatmentPlanStatusClosed.
  ///
  /// In vi, this message translates to:
  /// **'Đã đóng'**
  String get treatmentPlanStatusClosed;

  /// No description provided for @treatmentPlanSeverity.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ'**
  String get treatmentPlanSeverity;

  /// No description provided for @treatmentPlanSite.
  ///
  /// In vi, this message translates to:
  /// **'Vị trí điều trị'**
  String get treatmentPlanSite;

  /// No description provided for @treatmentPlanAdherenceLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tuân thủ phác đồ'**
  String get treatmentPlanAdherenceLabel;

  /// No description provided for @treatmentPlanSuspected.
  ///
  /// In vi, this message translates to:
  /// **'Căn nguyên nghi ngờ'**
  String get treatmentPlanSuspected;

  /// No description provided for @treatmentPlanMedicines.
  ///
  /// In vi, this message translates to:
  /// **'Kháng sinh'**
  String get treatmentPlanMedicines;

  /// No description provided for @treatmentPlanNoMedicines.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có kháng sinh.'**
  String get treatmentPlanNoMedicines;

  /// No description provided for @treatmentPlanReasonForChoice.
  ///
  /// In vi, this message translates to:
  /// **'Lý do chọn thuốc'**
  String get treatmentPlanReasonForChoice;

  /// No description provided for @treatmentPlanClose.
  ///
  /// In vi, this message translates to:
  /// **'Dừng phác đồ'**
  String get treatmentPlanClose;

  /// No description provided for @treatmentPlanCloseTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dừng phác đồ điều trị'**
  String get treatmentPlanCloseTitle;

  /// No description provided for @treatmentPlanCloseDescriptionPrefix.
  ///
  /// In vi, this message translates to:
  /// **'Phác đồ của bệnh nhân {name} sẽ được dừng lại. Sau khi hoàn tất, phác đồ chuyển sang lưu trữ và '**
  String treatmentPlanCloseDescriptionPrefix(String name);

  /// No description provided for @treatmentPlanCloseWarning.
  ///
  /// In vi, this message translates to:
  /// **'không thể chỉnh sửa'**
  String get treatmentPlanCloseWarning;

  /// No description provided for @treatmentPlanCloseDescriptionSuffix.
  ///
  /// In vi, this message translates to:
  /// **' thêm nội dung.'**
  String get treatmentPlanCloseDescriptionSuffix;

  /// No description provided for @treatmentPlanCloseReasonLabel.
  ///
  /// In vi, this message translates to:
  /// **'Lý do dừng phác đồ'**
  String get treatmentPlanCloseReasonLabel;

  /// No description provided for @treatmentPlanCloseReasonHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lý do dừng phác đồ (bệnh nhân hồi phục, chuyển viện, thay đổi phác đồ)...'**
  String get treatmentPlanCloseReasonHint;

  /// No description provided for @treatmentPlanCloseReasonCounter.
  ///
  /// In vi, this message translates to:
  /// **'{count}/500 ký tự'**
  String treatmentPlanCloseReasonCounter(int count);

  /// No description provided for @treatmentPlanCloseConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Dừng phác đồ'**
  String get treatmentPlanCloseConfirm;

  /// No description provided for @treatmentPlanCloseSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã dừng phác đồ điều trị.'**
  String get treatmentPlanCloseSuccess;

  /// No description provided for @treatmentPlanCloseFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể dừng phác đồ. Vui lòng thử lại.'**
  String get treatmentPlanCloseFailed;

  /// No description provided for @treatmentPlanErrReasonRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập lý do dừng phác đồ.'**
  String get treatmentPlanErrReasonRequired;

  /// No description provided for @treatmentPlanViewSemantic.
  ///
  /// In vi, this message translates to:
  /// **'Xem chi tiết phác đồ'**
  String get treatmentPlanViewSemantic;

  /// No description provided for @clinicalVariableTitle.
  ///
  /// In vi, this message translates to:
  /// **'Biến số lâm sàng'**
  String get clinicalVariableTitle;

  /// No description provided for @clinicalVariableSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý tham số'**
  String get clinicalVariableSubtitle;

  /// No description provided for @clinicalVariableDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết biến số'**
  String get clinicalVariableDetailTitle;

  /// No description provided for @clinicalVariableSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên hoặc mã...'**
  String get clinicalVariableSearchHint;

  /// No description provided for @clinicalVariableRequired.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc'**
  String get clinicalVariableRequired;

  /// No description provided for @clinicalVariableDetailConfig.
  ///
  /// In vi, this message translates to:
  /// **'Cấu hình biến số'**
  String get clinicalVariableDetailConfig;

  /// No description provided for @clinicalVariableValueType.
  ///
  /// In vi, this message translates to:
  /// **'Loại dữ liệu'**
  String get clinicalVariableValueType;

  /// No description provided for @clinicalVariableCanonicalUnit.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị chuẩn'**
  String get clinicalVariableCanonicalUnit;

  /// No description provided for @clinicalVariableIsRequired.
  ///
  /// In vi, this message translates to:
  /// **'Tính bắt buộc'**
  String get clinicalVariableIsRequired;

  /// No description provided for @clinicalVariableRequiredYes.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc nhập'**
  String get clinicalVariableRequiredYes;

  /// No description provided for @clinicalVariableOptional.
  ///
  /// In vi, this message translates to:
  /// **'Tùy chọn'**
  String get clinicalVariableOptional;

  /// No description provided for @clinicalVariablePrerequisite.
  ///
  /// In vi, this message translates to:
  /// **'Điều kiện tiên quyết'**
  String get clinicalVariablePrerequisite;

  /// No description provided for @clinicalVariableRange.
  ///
  /// In vi, this message translates to:
  /// **'Khoảng giá trị'**
  String get clinicalVariableRange;

  /// No description provided for @clinicalVariableAccepted.
  ///
  /// In vi, this message translates to:
  /// **'Chấp nhận'**
  String get clinicalVariableAccepted;

  /// No description provided for @clinicalVariableNormal.
  ///
  /// In vi, this message translates to:
  /// **'Bình thường'**
  String get clinicalVariableNormal;

  /// No description provided for @clinicalVariableOptions.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách lựa chọn'**
  String get clinicalVariableOptions;

  /// No description provided for @valueTypeNumeric.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số'**
  String get valueTypeNumeric;

  /// No description provided for @valueTypeBoolean.
  ///
  /// In vi, this message translates to:
  /// **'Có / Không'**
  String get valueTypeBoolean;

  /// No description provided for @valueTypeCategorical.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại'**
  String get valueTypeCategorical;

  /// No description provided for @valueTypeOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get valueTypeOther;

  /// No description provided for @variableCategoryPersonal.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân'**
  String get variableCategoryPersonal;

  /// No description provided for @variableCategoryPersonalShort.
  ///
  /// In vi, this message translates to:
  /// **'Cá nhân'**
  String get variableCategoryPersonalShort;

  /// No description provided for @variableCategoryMedicalHistory.
  ///
  /// In vi, this message translates to:
  /// **'Tiền sử bệnh'**
  String get variableCategoryMedicalHistory;

  /// No description provided for @variableCategoryParaclinical.
  ///
  /// In vi, this message translates to:
  /// **'Cận lâm sàng'**
  String get variableCategoryParaclinical;

  /// No description provided for @variableCategoryClinical.
  ///
  /// In vi, this message translates to:
  /// **'Lâm sàng'**
  String get variableCategoryClinical;

  /// No description provided for @variableCategoryOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get variableCategoryOther;

  /// No description provided for @filterTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bộ lọc dữ liệu'**
  String get filterTitle;

  /// No description provided for @filterRequired.
  ///
  /// In vi, this message translates to:
  /// **'Tính bắt buộc'**
  String get filterRequired;

  /// No description provided for @filterRequiredYes.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc'**
  String get filterRequiredYes;

  /// No description provided for @filterRequiredNo.
  ///
  /// In vi, this message translates to:
  /// **'Không bắt buộc'**
  String get filterRequiredNo;

  /// No description provided for @filterCategory.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại'**
  String get filterCategory;

  /// No description provided for @filterValueType.
  ///
  /// In vi, this message translates to:
  /// **'Loại giá trị'**
  String get filterValueType;

  /// No description provided for @filterClear.
  ///
  /// In vi, this message translates to:
  /// **'Xóa bộ lọc'**
  String get filterClear;

  /// No description provided for @filterApply.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng'**
  String get filterApply;

  /// No description provided for @rangeUnlimited.
  ///
  /// In vi, this message translates to:
  /// **'Không giới hạn{unit}'**
  String rangeUnlimited(String unit);

  /// No description provided for @rangeSingle.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị {symbol} {value}{unit}'**
  String rangeSingle(String symbol, String value, String unit);

  /// No description provided for @rangeBetween.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị {minSymbol} {min}{unit} và {maxSymbol} {max}{unit}'**
  String rangeBetween(
    String minSymbol,
    String min,
    String unit,
    String maxSymbol,
    String max,
  );

  /// No description provided for @clinicalMetricTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thang điểm lâm sàng'**
  String get clinicalMetricTitle;

  /// No description provided for @clinicalMetricSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Các bộ tiêu chí & đánh giá'**
  String get clinicalMetricSubtitle;

  /// No description provided for @clinicalMetricSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên thang điểm...'**
  String get clinicalMetricSearchHint;

  /// No description provided for @clinicalMetricDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thang điểm'**
  String get clinicalMetricDetailTitle;

  /// No description provided for @clinicalMetricDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thang điểm đánh giá'**
  String get clinicalMetricDetailSubtitle;

  /// No description provided for @clinicalMetricApplied.
  ///
  /// In vi, this message translates to:
  /// **'Đang áp dụng'**
  String get clinicalMetricApplied;

  /// No description provided for @clinicalMetricVersion.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản: {version}'**
  String clinicalMetricVersion(String version);

  /// No description provided for @clinicalMetricGeneral.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin chung'**
  String get clinicalMetricGeneral;

  /// No description provided for @clinicalMetricCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã'**
  String get clinicalMetricCode;

  /// No description provided for @clinicalMetricPublisher.
  ///
  /// In vi, this message translates to:
  /// **'Phát hành'**
  String get clinicalMetricPublisher;

  /// No description provided for @clinicalMetricDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get clinicalMetricDescription;

  /// No description provided for @clinicalMetricMajor.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí chính'**
  String get clinicalMetricMajor;

  /// No description provided for @clinicalMetricMinor.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí phụ'**
  String get clinicalMetricMinor;

  /// No description provided for @clinicalMetricScoring.
  ///
  /// In vi, this message translates to:
  /// **'Các tiêu chí tính điểm'**
  String get clinicalMetricScoring;

  /// No description provided for @clinicalMetricPoints.
  ///
  /// In vi, this message translates to:
  /// **'+ {points} điểm'**
  String clinicalMetricPoints(String points);

  /// No description provided for @criteriaTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu chí'**
  String get criteriaTitle;

  /// No description provided for @criteriaSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách các tiêu chí đánh giá'**
  String get criteriaSubtitle;

  /// No description provided for @criteriaSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên tiêu chí...'**
  String get criteriaSearchHint;

  /// No description provided for @riskFactorTitle.
  ///
  /// In vi, this message translates to:
  /// **'Yếu tố nguy cơ'**
  String get riskFactorTitle;

  /// No description provided for @riskFactorSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Theo tác nhân gây bệnh'**
  String get riskFactorSubtitle;

  /// No description provided for @riskFactorListLabel.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách yếu tố'**
  String get riskFactorListLabel;

  /// No description provided for @riskFactorDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết yếu tố'**
  String get riskFactorDetailTitle;

  /// No description provided for @riskFactorDetailSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Nguy cơ theo tác nhân'**
  String get riskFactorDetailSubtitle;

  /// No description provided for @riskFactorPathogen.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân liên quan'**
  String get riskFactorPathogen;

  /// No description provided for @riskFactorFormula.
  ///
  /// In vi, this message translates to:
  /// **'Công thức điều kiện'**
  String get riskFactorFormula;

  /// No description provided for @riskFactorLoadInfo.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được thông tin'**
  String get riskFactorLoadInfo;

  /// No description provided for @riskFactorPathogensList.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được danh sách tác nhân'**
  String get riskFactorPathogensList;

  /// No description provided for @riskFactorAllPathogens.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả tác nhân'**
  String get riskFactorAllPathogens;

  /// No description provided for @riskFactorPathogenLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân'**
  String get riskFactorPathogenLabel;

  /// No description provided for @suspectedCauseTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nguyên nhân nghi ngờ'**
  String get suspectedCauseTitle;

  /// No description provided for @suspectedCauseSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ & nơi điều trị'**
  String get suspectedCauseSubtitle;

  /// No description provided for @suspectedCauseListLabel.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách tác nhân'**
  String get suspectedCauseListLabel;

  /// No description provided for @suspectedCausePathogen.
  ///
  /// In vi, this message translates to:
  /// **'Tác nhân (Pathogen)'**
  String get suspectedCausePathogen;

  /// No description provided for @suspectedCauseSeverity.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ nghiêm trọng'**
  String get suspectedCauseSeverity;

  /// No description provided for @suspectedCauseSite.
  ///
  /// In vi, this message translates to:
  /// **'Nơi điều trị'**
  String get suspectedCauseSite;
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
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
