// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get commonRetry => 'Thử lại';

  @override
  String get commonNoResults => 'Không tìm thấy kết quả nào.';

  @override
  String get commonLoadMoreFailed => 'Không thể tải thêm. Nhấn để thử lại';

  @override
  String get commonLoadDataError => 'Không thể tải dữ liệu';

  @override
  String get commonLoadInfoError => 'Không tải được thông tin';

  @override
  String get commonNoData => 'Không có dữ liệu';

  @override
  String get commonDescription => 'Mô tả';

  @override
  String get commonCode => 'Mã';

  @override
  String get commonApply => 'Áp dụng';

  @override
  String get commonClearFilters => 'Xóa bộ lọc';

  @override
  String get commonAll => 'Tất cả';

  @override
  String get commonFilters => 'Bộ lọc dữ liệu';

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonBack => 'Quay lại';

  @override
  String get commonComingSoon => 'Tính năng đang phát triển.';

  @override
  String commonTabComingSoon(String label) {
    return 'Tab \"$label\" sẽ được bổ sung sau.';
  }

  @override
  String commonFeatureComingSoon(String feature) {
    return 'Tính năng $feature đang phát triển';
  }

  @override
  String get commonNotAvailable => 'Chưa có thông tin';

  @override
  String get commonNone => 'Không có';

  @override
  String get commonOptional => 'Tùy chọn';

  @override
  String get commonRequired => 'Bắt buộc nhập';

  @override
  String get commonActive => 'Đang áp dụng';

  @override
  String commonVersion(String version) {
    return 'Phiên bản: $version';
  }

  @override
  String commonPoints(String score) {
    return '$score điểm';
  }

  @override
  String commonAddPoints(String score) {
    return '+ $score điểm';
  }

  @override
  String get commonLoading => 'Đang tải...';

  @override
  String get commonLoadFailedShort => 'Lỗi tải dữ liệu';

  @override
  String get navPatients => 'Bệnh nhân';

  @override
  String get navLookup => 'Tra cứu';

  @override
  String get navDiagnosis => 'Chẩn đoán';

  @override
  String get navCalculators => 'Máy tính';

  @override
  String get navStatistics => 'Thống kê';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsSubtitle => 'Cá nhân hóa trải nghiệm';

  @override
  String get settingsOpen => 'Mở cài đặt';

  @override
  String get settingsClose => 'Đóng cài đặt';

  @override
  String get settingsProfileSpecialty => 'Chuyên khoa Hô hấp';

  @override
  String get settingsDoctorFallback => 'Bác sĩ';

  @override
  String get settingsAppearance => 'Giao diện';

  @override
  String get settingsTheme => 'Giao diện';

  @override
  String get settingsThemeSubtitle => 'Sáng hoặc tối';

  @override
  String get settingsThemeSheetTitle => 'Chế độ hiển thị';

  @override
  String get settingsThemeSystem => 'Hệ thống';

  @override
  String get settingsThemeLight => 'Sáng';

  @override
  String get settingsThemeDark => 'Tối';

  @override
  String get settingsFontSize => 'Cỡ chữ';

  @override
  String get settingsTextSmall => 'Nhỏ';

  @override
  String get settingsTextStandard => 'Mặc định';

  @override
  String get settingsTextLarge => 'Lớn';

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get settingsLanguageVietnamese => 'Tiếng Việt';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLogout => 'Đăng xuất';

  @override
  String get settingsLogoutConfirmTitle => 'Đăng xuất?';

  @override
  String get settingsLogoutConfirmBody =>
      'Bạn sẽ cần đăng nhập lại để tiếp tục sử dụng RespiraAMS.';

  @override
  String get splashSubtitle => 'Không gian làm việc lâm sàng cho hô hấp';

  @override
  String get authLoginTitle => 'Đăng nhập';

  @override
  String get authLoginSubtitle =>
      'Tiếp tục vào không gian làm việc RespiraAMS.';

  @override
  String get authEmailLabel => 'Email hoặc mã nhân viên';

  @override
  String get authPasswordLabel => 'Mật khẩu';

  @override
  String get authForgotPassword => 'Quên mật khẩu?';

  @override
  String get authLoginButton => 'Đăng nhập';

  @override
  String get authOr => 'hoặc';

  @override
  String get authUseStaffCode => 'Dùng mã nhân viên';

  @override
  String get authStaffCodeComingSoon =>
      'Đăng nhập bằng mã nhân viên sẽ được bổ sung sau.';

  @override
  String get authSecureSessionTitle => 'Phiên đăng nhập an toàn';

  @override
  String get authSecureSessionBody =>
      'Tự động khóa khi không hoạt động và bảo vệ theo vai trò.';

  @override
  String get authSupportFooter =>
      'Cần hỗ trợ? Liên hệ quản trị viên bệnh viện.';

  @override
  String get authMissingCredentials =>
      'Vui lòng nhập email/mã nhân viên và mật khẩu.';

  @override
  String get authEmailInvalid => 'Email chưa đúng định dạng.';

  @override
  String get authServerUnreachable =>
      'Không thể kết nối máy chủ. Vui lòng thử lại.';

  @override
  String get authForgotTitle => 'Quên mật khẩu?';

  @override
  String get authForgotBody =>
      'Nhập email công việc. Hệ thống sẽ gửi mã xác thực gồm 6 chữ số.';

  @override
  String get authWorkEmailLabel => 'Email công việc';

  @override
  String get authSendCode => 'Gửi mã xác thực';

  @override
  String get authBackToLogin => 'Quay lại đăng nhập';

  @override
  String get authNoEmailTitle => 'Không nhận được email?';

  @override
  String get authNoEmailBody =>
      'Kiểm tra thư rác hoặc liên hệ quản trị viên để xác minh tài khoản.';

  @override
  String get authOtpTitle => 'Nhập mã xác thực';

  @override
  String authOtpSentTo(String email) {
    return 'Mã 6 chữ số đã được gửi đến $email';
  }

  @override
  String get authResend => 'Gửi lại mã';

  @override
  String authResendIn(String seconds) {
    return 'Gửi lại mã sau 00:$seconds';
  }

  @override
  String get authConfirm => 'Xác nhận';

  @override
  String get authAccountSecurityTitle => 'Bảo mật tài khoản';

  @override
  String get authAccountSecurityBody =>
      'Không chia sẻ mã xác thực. Mã sẽ hết hiệu lực sau 10 phút và chỉ dùng một lần.';

  @override
  String get authChangeEmail => 'Đổi email nhận mã';

  @override
  String get authStepIdentity => 'Bước 1/2 · Xác minh danh tính';

  @override
  String get authNewPasswordTitle => 'Tạo mật khẩu mới';

  @override
  String get authNewPasswordBody =>
      'Chọn mật khẩu mạnh để bảo vệ dữ liệu bệnh nhân và phiên làm việc.';

  @override
  String get authNewPasswordLabel => 'Mật khẩu mới';

  @override
  String get authConfirmPasswordLabel => 'Xác nhận mật khẩu';

  @override
  String get authPasswordRequirements => 'Mật khẩu cần có';

  @override
  String get authMinLength => 'Tối thiểu 8 ký tự';

  @override
  String get authUppercase => 'Ít nhất 1 chữ in hoa';

  @override
  String get authDigitOrSpecial => 'Ít nhất 1 số hoặc ký tự đặc biệt';

  @override
  String get authPasswordMismatch => 'Mật khẩu xác nhận chưa khớp.';

  @override
  String get authUpdatePassword => 'Cập nhật mật khẩu';

  @override
  String get authCancelBack => 'Hủy và quay lại';

  @override
  String get authStepPassword => 'Bước 2/2 · Thiết lập mật khẩu';

  @override
  String get authResetSuccessTitle => 'Mật khẩu đã được cập nhật';

  @override
  String get authResetSuccessBody =>
      'Bạn có thể đăng nhập lại và tiếp tục công việc trên RespiraAMS.';

  @override
  String get authDemoDoctorName => 'BS. Lê Hoàng Minh';

  @override
  String get authDoctorRoleVerified =>
      'Chuyên khoa Hô hấp · Tài khoản đã xác minh';

  @override
  String get authWorkspaceReady => 'Không gian làm việc đã sẵn sàng';

  @override
  String get authRestoreAccess =>
      'Dữ liệu và quyền truy cập sẽ được khôi phục sau đăng nhập.';

  @override
  String get authLoginNow => 'Đăng nhập ngay';

  @override
  String get authBackToWelcome => 'Về trang chào mừng';

  @override
  String get authWorkspaceEyebrow => 'KHÔNG GIAN LÀM VIỆC LÂM SÀNG';

  @override
  String authWelcomeGreeting(String name) {
    return 'Chào mừng, $name';
  }

  @override
  String get authWelcomeSubtitle => 'Sẵn sàng theo dõi các ca hô hấp hôm nay.';

  @override
  String get authWelcomeBulletPatients => '12 bệnh nhân đang theo dõi';

  @override
  String get authWelcomeBulletAttention => '3 ca cần chú ý trong ngày';

  @override
  String get authWelcomeBulletSynced => 'Dữ liệu đồng bộ lúc 19:28';

  @override
  String get authStart => 'Bắt đầu';

  @override
  String get authPrivacyFooter =>
      'Dữ liệu y tế được bảo vệ theo phân quyền hệ thống.';

  @override
  String get commonTryAgain => 'Thử lại';

  @override
  String get commonEnterNumber => 'Nhập số';

  @override
  String get commonServerUnreachable =>
      'Không thể kết nối máy chủ. Vui lòng kiểm tra kết nối mạng.';

  @override
  String commonBadRequest(int status) {
    return 'Yêu cầu không hợp lệ (mã $status).';
  }

  @override
  String commonLoadErrorWith(String error) {
    return 'Không thể tải dữ liệu: $error';
  }

  @override
  String commonLoadInfoErrorWith(String error) {
    return 'Không tải được thông tin: $error';
  }

  @override
  String get commonOther => 'Khác';

  @override
  String get commonYesNo => 'Có / Không';

  @override
  String get commonMlPerMin => 'mL/phút';

  @override
  String get genderMale => 'Nam';

  @override
  String get genderFemale => 'Nữ';

  @override
  String get patientStatusTreating => 'Đang điều trị';

  @override
  String get patientStatusRecovered => 'Hồi phục';

  @override
  String get patientStatusDeceased => 'Tử vong';

  @override
  String get patientStatusOutOfScope => 'Ngoài phạm vi điều trị';

  @override
  String patientAge(int age) {
    return '$age tuổi';
  }

  @override
  String get patientListTitle => 'Danh sách bệnh nhân';

  @override
  String patientFollowingCount(int count) {
    return '$count bệnh nhân đang theo dõi';
  }

  @override
  String get patientFilterAll => 'Tất cả';

  @override
  String get patientFilterAttention => 'Cần chú ý';

  @override
  String get patientFilterHighRisk => 'Nguy cơ cao';

  @override
  String patientCount(int count) {
    return '$count bệnh nhân';
  }

  @override
  String get patientPrioritySort => 'Ưu tiên';

  @override
  String get patientSearchHint => 'Tìm theo tên hoặc mã bệnh án';

  @override
  String get patientAddSemantic => 'Thêm bệnh nhân';

  @override
  String get patientEmpty => 'Không tìm thấy bệnh nhân phù hợp.';

  @override
  String get patientDetailTitle => 'Chi tiết bệnh nhân';

  @override
  String get patientDetailSubtitle =>
      'Thông tin chỉ đọc và tiến trình điều trị';

  @override
  String get patientProfileError => 'Không thể tải hồ sơ bệnh nhân.';

  @override
  String get patientNoSelection => 'Chưa chọn bệnh nhân.';

  @override
  String get patientRecordSection => 'Thông tin hồ sơ';

  @override
  String get patientDobGender => 'Ngày sinh · Giới tính';

  @override
  String get patientInsurance => 'BHYT';

  @override
  String get patientAddress => 'Địa chỉ';

  @override
  String get patientVitals => 'Thể trạng';

  @override
  String get patientTreatmentStatus => 'Trạng thái điều trị';

  @override
  String get patientProgressSection => 'Tiến trình điều trị';

  @override
  String get patientNoProgress => 'Chưa có diễn biến điều trị.';

  @override
  String get patientAddTreatment => 'Thêm điều trị';

  @override
  String get patientUpdateStatus => 'Cập nhật trạng thái';

  @override
  String patientEpisode(int index) {
    return 'Đợt $index';
  }

  @override
  String get patientSavedTreatment => 'Điều trị đã lưu';

  @override
  String get patientAddTitle => 'Thêm bệnh nhân';

  @override
  String get patientAddSubtitle => 'Tạo hồ sơ bệnh nhân mới';

  @override
  String get patientLastName => 'Họ';

  @override
  String get patientFirstName => 'Tên';

  @override
  String get patientRecordCode => 'Mã bệnh án';

  @override
  String get patientDob => 'Ngày sinh';

  @override
  String get patientInsuranceCard => 'Số thẻ BHYT';

  @override
  String get patientPhone => 'Số điện thoại';

  @override
  String get patientHeight => 'Chiều cao';

  @override
  String get patientWeight => 'Cân nặng';

  @override
  String get patientProvince => 'Tỉnh/Thành phố';

  @override
  String get patientGender => 'Giới tính';

  @override
  String get patientSaving => 'Đang lưu…';

  @override
  String get patientSaveRecord => 'Lưu hồ sơ';

  @override
  String get patientErrName => 'Vui lòng nhập họ và tên.';

  @override
  String get patientErrCode => 'Vui lòng nhập mã bệnh án.';

  @override
  String get patientErrDob => 'Vui lòng nhập ngày sinh.';

  @override
  String get patientErrDobFormat =>
      'Ngày sinh không hợp lệ (định dạng dd/MM/yyyy).';

  @override
  String get patientErrPhone => 'Số điện thoại không hợp lệ.';

  @override
  String get patientErrInsurance => 'Số thẻ BHYT phải gồm 10 chữ số.';

  @override
  String get patientErrHeight => 'Chiều cao phải lớn hơn 0.';

  @override
  String get patientErrWeight => 'Cân nặng phải lớn hơn 0.';

  @override
  String get patientErrAddress => 'Vui lòng nhập địa chỉ.';

  @override
  String get patientErrCity => 'Vui lòng nhập tỉnh/thành phố.';

  @override
  String get patientCreateFailed =>
      'Không thể tạo bệnh nhân. Vui lòng thử lại.';

  @override
  String get progressTitle => 'Thêm diễn biến';

  @override
  String get progressSubtitleTargeted => 'Dựa trên kết quả vi sinh đã có';

  @override
  String get progressSubtitleEmpirical => 'Ghi nhận thay đổi điều trị mới nhất';

  @override
  String get progressTreatmentTypeNext => 'Loại điều trị tiếp theo';

  @override
  String get progressTreatmentType => 'Loại điều trị';

  @override
  String get progressContinueTargeted => 'Tiếp tục điều trị đích';

  @override
  String get progressSave => 'Lưu diễn biến';

  @override
  String get progressReason => 'Lý do thay đổi';

  @override
  String get progressHasMicro => 'Có kết quả vi sinh';

  @override
  String get progressHasMicroDesc => 'Chuyển sang điều trị đích khi phù hợp.';

  @override
  String get progressPoorResponse => 'Đáp ứng kém';

  @override
  String get progressPoorResponseDesc =>
      'Triệu chứng không cải thiện sau theo dõi.';

  @override
  String get progressLockTitle => 'Không thể chỉnh sửa sau khi lưu';

  @override
  String get progressLockDesc => 'Tạo diễn biến mới nếu cần cập nhật tiếp.';

  @override
  String get progressTargetedAlertTitle =>
      'Điều trị đích dựa trên kết quả vi sinh';

  @override
  String get progressTargetedAlertDesc =>
      'Kiểm tra tác nhân và kháng sinh đồ trước khi chọn thuốc.';

  @override
  String get treatmentEmpirical => 'Kinh nghiệm';

  @override
  String get treatmentTargeted => 'Điều trị đích';

  @override
  String get diagnosisTitle => 'Chẩn đoán kinh nghiệm';

  @override
  String diagnosisStepProgress(int step, int total, String title) {
    return 'Bước $step/$total · $title';
  }

  @override
  String get diagnosisBack => 'Quay lại';

  @override
  String get diagnosisContinue => 'Tiếp tục';

  @override
  String get diagnosisRun => 'Chẩn đoán';

  @override
  String get diagnosisPersonalInfo => 'Thông tin cá nhân';

  @override
  String get diagnosisVitalSigns => 'Chỉ số sinh tồn';

  @override
  String get diagnosisLabResults => 'Kết quả xét nghiệm';

  @override
  String get diagnosisComorbidities => 'Bệnh nền & nguy cơ';

  @override
  String get diagnosisEmptyForm => 'Không có dữ liệu biểu mẫu.';

  @override
  String get diagnosisFormLoadFailed => 'Không thể tải biểu mẫu chẩn đoán.';

  @override
  String get diagnosisResultTitle => 'Kết quả chẩn đoán';

  @override
  String get diagnosisResultSubtitle => 'Kinh nghiệm · Viêm phổi cộng đồng';

  @override
  String get diagnosisSaveResult => 'Lưu kết quả';

  @override
  String get diagnosisTabResult => 'Kết quả';

  @override
  String get diagnosisTabSuspected => 'Căn nguyên';

  @override
  String get diagnosisTabEvidences => 'Bằng chứng';

  @override
  String get diagnosisSectionDiagnosis => 'Chẩn đoán';

  @override
  String get diagnosisCommunityPneumonia => 'Viêm phổi cộng đồng';

  @override
  String get diagnosisEmpiricalLabel => 'Chẩn đoán kinh nghiệm';

  @override
  String get diagnosisSectionAssessment => 'Đánh giá';

  @override
  String get diagnosisSeverity => 'Mức độ';

  @override
  String get diagnosisTreatment => 'Điều trị';

  @override
  String get diagnosisConfirmNote =>
      'Kết quả cần được bác sĩ xác nhận trước khi áp dụng điều trị.';

  @override
  String get suspectedHeavy => 'Căn nguyên nghi ngờ cao';

  @override
  String get suspectedWorth => 'Căn nguyên cần lưu ý';

  @override
  String get evidenceSection => 'Bằng chứng lâm sàng';

  @override
  String get diagnosisNoData => 'Không có dữ liệu.';

  @override
  String evidencePoints(int score) {
    return 'Điểm $score';
  }

  @override
  String get evidenceMajor => 'Chính';

  @override
  String get evidenceMinor => 'Phụ';

  @override
  String get severityMild => 'Nhẹ';

  @override
  String get severityModerate => 'Trung bình';

  @override
  String get severitySevere => 'Nặng';

  @override
  String get siteInpatient => 'Nội trú';

  @override
  String get siteOutpatient => 'Ngoại trú';

  @override
  String get siteIcu => 'ICU';

  @override
  String get riskHigh => 'Nguy cơ cao';

  @override
  String get riskLow => 'Nguy cơ thấp';

  @override
  String get riskWatch => 'Cần theo dõi';

  @override
  String get alertPregnantTitle => 'Bệnh nhân đang mang thai / cho con bú';

  @override
  String get alertPregnantDesc => 'Cân nhắc kỹ trước khi chỉ định kháng sinh.';

  @override
  String get alertMissingTitle => 'Thiếu thông tin cần thiết';

  @override
  String get targetedTitle => 'Chẩn đoán vi sinh';

  @override
  String get targetedSubtitle => 'Mỗi đường dùng là một lựa chọn thuốc riêng';

  @override
  String get targetedLoadError =>
      'Không thể tải khuyến nghị. Vui lòng thử lại.';

  @override
  String get targetedSelectDrugs => 'Chọn thuốc + đường dùng';

  @override
  String get targetedSelectedSummary => 'Đã chọn theo thuốc + đường dùng';

  @override
  String get targetedSave => 'Lưu điều trị đích';

  @override
  String get microBacteria => 'Vi khuẩn';

  @override
  String get microLatestAntibiogram => 'Kháng sinh đồ gần nhất';

  @override
  String get diagnosisFlowNoPatient => 'Chưa chọn bệnh nhân.';

  @override
  String get diagnosisFlowFormError => 'Không thể tải biểu mẫu chẩn đoán.';

  @override
  String diagnosisFlowMissing(String fields) {
    return 'Thiếu thông tin bắt buộc: $fields.';
  }

  @override
  String get routeIntravenous => 'Tiêm tĩnh mạch';

  @override
  String get routeOral => 'Uống';

  @override
  String get routeIntramuscular => 'Tiêm bắp';

  @override
  String get routeAbbrevIv => 'TM';

  @override
  String get routeAbbrevOral => 'Uống';

  @override
  String get calculatorTitle => 'Máy tính';

  @override
  String get calculatorSubtitle => 'Công cụ tính lâm sàng';

  @override
  String get calculatorCommonTools => 'Công cụ thường dùng';

  @override
  String calculatorComingSoon(String title) {
    return 'Máy tính \"$title\" sẽ được bổ sung sau.';
  }

  @override
  String get calcCurb65Desc => 'Đánh giá mức độ nặng viêm phổi';

  @override
  String get calcEgfrDesc => 'Ước tính chức năng thận';

  @override
  String get calcCrclDesc => 'Độ thanh thải creatinin';

  @override
  String get calcBmiDesc => 'Chỉ số khối cơ thể';

  @override
  String get calcQsofaDesc => 'Đánh giá nhanh nguy cơ nhiễm khuẩn';

  @override
  String get calcClinicalCalculator => 'Máy tính lâm sàng';

  @override
  String get calcInputTab => 'Nhập liệu';

  @override
  String get calcExplanationTab => 'Giải thích';

  @override
  String get calcCriteriaBanner => 'Tiêu chí CURB-65';

  @override
  String get calcConfusion => 'Lú lẫn mới xuất hiện';

  @override
  String get calcConfusionDesc => 'Confusion';

  @override
  String get calcUrea => 'Urea';

  @override
  String get calcUreaDesc => 'Ngưỡng > 7 mmol/L';

  @override
  String get calcRespRate => 'Nhịp thở';

  @override
  String get calcRespRateDesc => 'Ngưỡng ≥ 30 lần/phút';

  @override
  String get calcRespRateUnit => 'lần/phút';

  @override
  String get calcBloodPressure => 'Huyết áp';

  @override
  String get calcBpThreshold => 'Ngưỡng: SBP < 90 mmHg hoặc DBP ≤ 60 mmHg';

  @override
  String get calcAge => 'Tuổi';

  @override
  String get calcAgeDesc => 'Ngưỡng ≥ 65 tuổi';

  @override
  String get calcAgeUnit => 'tuổi';

  @override
  String get calcCalculate => 'Tính';

  @override
  String get calcMethodTitle => 'Phương pháp tính';

  @override
  String get calcMethodBody =>
      'Điểm CURB-65 = tổng số tiêu chí được đáp ứng, từ 0 đến 5 điểm. Mỗi tiêu chí đáp ứng đóng góp 1 điểm.';

  @override
  String get calcDescriptionTitle => 'Mô tả';

  @override
  String get calcDescriptionBody =>
      'CURB-65 hỗ trợ đánh giá mức độ nặng của viêm phổi cộng đồng.';

  @override
  String get calcConfirmNote =>
      'Kết quả cần được bác sĩ xác nhận trong bối cảnh lâm sàng.';

  @override
  String get calcComponentsTitle => 'Các thành phần';

  @override
  String get calcComponentsBody =>
      'Lú lẫn · Urea > 7 mmol/L · Nhịp thở ≥ 30 · Huyết áp thấp · Tuổi ≥ 65.';

  @override
  String get calcThresholdNote =>
      'Chi tiết ngưỡng được hiển thị tại tab Nhập liệu.';

  @override
  String calcScorePoints(int score) {
    return '$score điểm';
  }

  @override
  String calcAdviceHigh(int score) {
    return 'Điểm $score → cân nhắc điều trị nội trú';
  }

  @override
  String calcAdviceMedium(int score) {
    return 'Điểm $score → cân nhắc nhập viện ngắn hạn';
  }

  @override
  String calcAdviceLow(int score) {
    return 'Điểm $score → có thể điều trị ngoại trú';
  }

  @override
  String get lookupTitle => 'Tra cứu';

  @override
  String get lookupSubtitle => 'Tài liệu y tế dành cho bác sĩ';

  @override
  String get lookupCategories => 'Danh mục';

  @override
  String get lookupSearchHint => 'Tìm thuốc, vi khuẩn, bệnh lý...';

  @override
  String get categoryAntibioticGroups => 'Nhóm kháng sinh';

  @override
  String get categoryAntibioticGroupsSub => 'Phân loại và mô tả';

  @override
  String get categoryAntibiotics => 'Kháng sinh';

  @override
  String get categoryAntibioticsSub => 'Liều dùng và phổ tác dụng';

  @override
  String get categoryPathogens => 'Tác nhân gây bệnh';

  @override
  String get categoryPathogensSub => 'Mô tả và độ nhạy';

  @override
  String get categoryClinicalVariables => 'Biến số lâm sàng';

  @override
  String get categoryClinicalVariablesSub => 'Các biến số dùng cho tiêu chí';

  @override
  String get categorySuspectedCauses => 'Nguyên nhân nghi ngờ';

  @override
  String get categorySuspectedCausesSub => 'Theo bệnh và mức độ';

  @override
  String get categoryCriteria => 'Tiêu chí đánh giá';

  @override
  String get categoryCriteriaSub => 'Danh sách các tiêu chí';

  @override
  String get categoryRiskFactors => 'Yếu tố nguy cơ';

  @override
  String get categoryRiskFactorsSub => 'Nguy cơ theo tác nhân';

  @override
  String get categoryClinicalScores => 'Thang điểm lâm sàng';

  @override
  String get categoryClinicalScoresSub => 'Các bộ tiêu chí & đánh giá';

  @override
  String get recentItemDrugTitle => 'Ceftriaxone';

  @override
  String get recentItemDrugSubtitle => 'Cephalosporin thế hệ 3';

  @override
  String get recentItemDrugTag => 'Thuốc';

  @override
  String get recentItemDiseaseTitle => 'Viêm phổi cộng đồng';

  @override
  String get recentItemDiseaseSubtitle => '5 tiêu chí đánh giá';

  @override
  String get recentItemDiseaseTag => 'Bệnh';

  @override
  String get statisticsTitle => 'Thống kê';

  @override
  String get statisticsSubtitle => 'Tổng quan hoạt động điều trị';

  @override
  String get statisticsWeekly => 'Chẩn đoán theo tuần';

  @override
  String get statisticsTopPathogens => 'Tác nhân thường gặp';

  @override
  String get statisticsSynced => 'Dữ liệu đã đồng bộ';

  @override
  String get statisticsUpdated => 'Cập nhật lúc 19:28 hôm nay';

  @override
  String get periodLast30Days => '30 ngày';

  @override
  String get periodThisQuarter => 'Quý này';

  @override
  String get periodThisYear => 'Năm nay';

  @override
  String get kpiDiagnoses => 'Chẩn đoán';

  @override
  String get kpiSaved => 'Đã lưu';

  @override
  String get kpiMicrobiology => 'Vi sinh';

  @override
  String statisticsWeek(int week) {
    return 'T$week';
  }

  @override
  String get antibioticTitle => 'Kháng sinh';

  @override
  String get antibioticSubtitle => 'Danh mục hoạt chất';

  @override
  String get antibioticSearchHint => 'Tìm kiếm kháng sinh...';

  @override
  String get antibioticEmpty => 'Không có dữ liệu kháng sinh';

  @override
  String get antibioticDetailSubtitle => 'Thông tin kháng sinh';

  @override
  String get antibioticDosage => 'Liều dùng';

  @override
  String get antibioticStandardDose => 'Liều chuẩn';

  @override
  String get antibioticNoInfo => 'Chưa có thông tin';

  @override
  String get antibioticGfrAdjust => 'Điều chỉnh theo GFR';

  @override
  String get antibioticGroupTitle => 'Nhóm kháng sinh';

  @override
  String get antibioticGroupSubtitle => 'Phân loại và mô tả';

  @override
  String get antibioticGroupSearchHint => 'Tìm kiếm nhóm...';

  @override
  String antibioticGroupDetailWithParent(String parent) {
    return 'Nhóm kháng sinh · $parent';
  }

  @override
  String get antibioticGroupDetail => 'Nhóm kháng sinh';

  @override
  String get antibioticGroupInfo => 'Thông tin nhóm';

  @override
  String get antibioticGroupParent => 'Nhóm cha';

  @override
  String get antibioticGroupDescription => 'Mô tả';

  @override
  String get antibioticGroupNone => 'Không có';

  @override
  String get antibioticGroupNoData => 'Không có dữ liệu';

  @override
  String get antibioticGroupAntibioticsInGroup => 'Kháng sinh trong nhóm';

  @override
  String get antibioticGroupLoadError => 'Không tải được dữ liệu';

  @override
  String get antibioticGroupEmpty => 'Chưa có kháng sinh nào trong nhóm này';

  @override
  String antibioticGroupClassification(String classification) {
    return 'Phân loại: $classification';
  }

  @override
  String get pathogenTitle => 'Tác nhân gây bệnh';

  @override
  String get pathogenSubtitle => 'Mô tả và độ nhạy';

  @override
  String get pathogenSearchHint => 'Tìm kiếm tác nhân...';

  @override
  String get pathogenAtypical => 'Không điển hình';

  @override
  String get pathogenDescription => 'Mô tả';

  @override
  String get clinicalVariableTitle => 'Biến số lâm sàng';

  @override
  String get clinicalVariableSubtitle => 'Quản lý tham số';

  @override
  String get clinicalVariableDetailTitle => 'Chi tiết biến số';

  @override
  String get clinicalVariableSearchHint => 'Tìm kiếm tên hoặc mã...';

  @override
  String get clinicalVariableRequired => 'Bắt buộc';

  @override
  String get clinicalVariableDetailConfig => 'Cấu hình biến số';

  @override
  String get clinicalVariableValueType => 'Loại dữ liệu';

  @override
  String get clinicalVariableCanonicalUnit => 'Đơn vị chuẩn';

  @override
  String get clinicalVariableIsRequired => 'Tính bắt buộc';

  @override
  String get clinicalVariableRequiredYes => 'Bắt buộc nhập';

  @override
  String get clinicalVariableOptional => 'Tùy chọn';

  @override
  String get clinicalVariablePrerequisite => 'Điều kiện tiên quyết';

  @override
  String get clinicalVariableRange => 'Khoảng giá trị';

  @override
  String get clinicalVariableAccepted => 'Chấp nhận';

  @override
  String get clinicalVariableNormal => 'Bình thường';

  @override
  String get clinicalVariableOptions => 'Danh sách lựa chọn';

  @override
  String get valueTypeNumeric => 'Nhập số';

  @override
  String get valueTypeBoolean => 'Có / Không';

  @override
  String get valueTypeCategorical => 'Phân loại';

  @override
  String get valueTypeOther => 'Khác';

  @override
  String get variableCategoryPersonal => 'Thông tin cá nhân';

  @override
  String get variableCategoryPersonalShort => 'Cá nhân';

  @override
  String get variableCategoryParaclinical => 'Cận lâm sàng';

  @override
  String get variableCategoryClinical => 'Lâm sàng';

  @override
  String get variableCategoryOther => 'Khác';

  @override
  String get filterTitle => 'Bộ lọc dữ liệu';

  @override
  String get filterRequired => 'Tính bắt buộc';

  @override
  String get filterRequiredYes => 'Bắt buộc';

  @override
  String get filterRequiredNo => 'Không bắt buộc';

  @override
  String get filterCategory => 'Phân loại';

  @override
  String get filterValueType => 'Loại giá trị';

  @override
  String get filterClear => 'Xóa bộ lọc';

  @override
  String get filterApply => 'Áp dụng';

  @override
  String rangeUnlimited(String unit) {
    return 'Không giới hạn$unit';
  }

  @override
  String rangeSingle(String symbol, String value, String unit) {
    return 'Giá trị $symbol $value$unit';
  }

  @override
  String rangeBetween(
    String minSymbol,
    String min,
    String unit,
    String maxSymbol,
    String max,
  ) {
    return 'Giá trị $minSymbol $min$unit và $maxSymbol $max$unit';
  }

  @override
  String get clinicalMetricTitle => 'Thang điểm lâm sàng';

  @override
  String get clinicalMetricSubtitle => 'Các bộ tiêu chí & đánh giá';

  @override
  String get clinicalMetricSearchHint => 'Tìm kiếm tên thang điểm...';

  @override
  String get clinicalMetricDetailTitle => 'Chi tiết thang điểm';

  @override
  String get clinicalMetricDetailSubtitle => 'Thang điểm đánh giá';

  @override
  String get clinicalMetricApplied => 'Đang áp dụng';

  @override
  String clinicalMetricVersion(String version) {
    return 'Phiên bản: $version';
  }

  @override
  String get clinicalMetricGeneral => 'Thông tin chung';

  @override
  String get clinicalMetricCode => 'Mã';

  @override
  String get clinicalMetricPublisher => 'Phát hành';

  @override
  String get clinicalMetricDescription => 'Mô tả';

  @override
  String get clinicalMetricMajor => 'Tiêu chí chính';

  @override
  String get clinicalMetricMinor => 'Tiêu chí phụ';

  @override
  String get clinicalMetricScoring => 'Các tiêu chí tính điểm';

  @override
  String clinicalMetricPoints(String points) {
    return '+ $points điểm';
  }

  @override
  String get criteriaTitle => 'Tiêu chí';

  @override
  String get criteriaSubtitle => 'Danh sách các tiêu chí đánh giá';

  @override
  String get criteriaSearchHint => 'Tìm kiếm tên tiêu chí...';

  @override
  String get riskFactorTitle => 'Yếu tố nguy cơ';

  @override
  String get riskFactorSubtitle => 'Theo tác nhân gây bệnh';

  @override
  String get riskFactorListLabel => 'Danh sách yếu tố';

  @override
  String get riskFactorDetailTitle => 'Chi tiết yếu tố';

  @override
  String get riskFactorDetailSubtitle => 'Nguy cơ theo tác nhân';

  @override
  String get riskFactorPathogen => 'Tác nhân liên quan';

  @override
  String get riskFactorFormula => 'Công thức điều kiện';

  @override
  String get riskFactorLoadInfo => 'Không tải được thông tin';

  @override
  String get riskFactorPathogensList => 'Không tải được danh sách tác nhân';

  @override
  String get riskFactorAllPathogens => 'Tất cả tác nhân';

  @override
  String get riskFactorPathogenLabel => 'Tác nhân';

  @override
  String get suspectedCauseTitle => 'Nguyên nhân nghi ngờ';

  @override
  String get suspectedCauseSubtitle => 'Mức độ & nơi điều trị';

  @override
  String get suspectedCauseListLabel => 'Danh sách tác nhân';

  @override
  String get suspectedCausePathogen => 'Tác nhân (Pathogen)';

  @override
  String get suspectedCauseSeverity => 'Mức độ nghiêm trọng';

  @override
  String get suspectedCauseSite => 'Nơi điều trị';
}
