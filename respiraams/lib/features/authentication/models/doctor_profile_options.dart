import '../../../l10n/l10n.dart';

/// `DegreeType` of `Respira.Doctor` — sent as a PascalCase string inside the
/// profile-update saga payload.
enum DoctorDegree {
  professor('Professor'),
  doctor('Doctor'),
  master('Master'),
  bachelor('Bachelor'),
  associate('Associate'),
  undergraduate('Undergraduate'),
  graduate('Graduate'),
  phd('PhD'),
  postDoc('PostDoc');

  const DoctorDegree(this.wireValue);

  final String wireValue;

  /// Parses a value returned by the API; `null` for unknown/blank strings.
  static DoctorDegree? fromWire(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;
    for (final degree in DoctorDegree.values) {
      if (degree.wireValue.toLowerCase() == normalized) return degree;
    }
    return null;
  }

  String label(AppLocalizations l10n) => switch (this) {
        DoctorDegree.professor => l10n.doctorDegreeProfessor,
        DoctorDegree.doctor => l10n.doctorDegreeDoctor,
        DoctorDegree.master => l10n.doctorDegreeMaster,
        DoctorDegree.bachelor => l10n.doctorDegreeBachelor,
        DoctorDegree.associate => l10n.doctorDegreeAssociate,
        DoctorDegree.undergraduate => l10n.doctorDegreeUndergraduate,
        DoctorDegree.graduate => l10n.doctorDegreeGraduate,
        DoctorDegree.phd => l10n.doctorDegreePhd,
        DoctorDegree.postDoc => l10n.doctorDegreePostDoc,
      };
}

/// `AcademicTitle` of `Respira.Doctor`.
enum DoctorAcademicTitle {
  none('None'),
  associateProfessor('AssociateProfessor'),
  professor('Professor');

  const DoctorAcademicTitle(this.wireValue);

  final String wireValue;

  static DoctorAcademicTitle? fromWire(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;
    for (final title in DoctorAcademicTitle.values) {
      if (title.wireValue.toLowerCase() == normalized) return title;
    }
    return null;
  }

  String label(AppLocalizations l10n) => switch (this) {
        DoctorAcademicTitle.none => l10n.doctorTitleNone,
        DoctorAcademicTitle.associateProfessor =>
          l10n.doctorTitleAssociateProfessor,
        DoctorAcademicTitle.professor => l10n.doctorTitleProfessor,
      };
}

/// `PositionType` of `Respira.Doctor`.
enum DoctorPosition {
  staffDoctor('StaffDoctor'),
  seniorDoctor('SeniorDoctor'),
  departmentDeputyHead('DepartmentDeputyHead'),
  headOfDepartment('HeadOfDepartment'),
  deputyDirector('DeputyDirector'),
  director('Director');

  const DoctorPosition(this.wireValue);

  final String wireValue;

  static DoctorPosition? fromWire(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;
    for (final position in DoctorPosition.values) {
      if (position.wireValue.toLowerCase() == normalized) return position;
    }
    return null;
  }

  String label(AppLocalizations l10n) => switch (this) {
        DoctorPosition.staffDoctor => l10n.doctorPositionStaff,
        DoctorPosition.seniorDoctor => l10n.doctorPositionSenior,
        DoctorPosition.departmentDeputyHead => l10n.doctorPositionDeputyHead,
        DoctorPosition.headOfDepartment => l10n.doctorPositionHead,
        DoctorPosition.deputyDirector => l10n.doctorPositionDeputyDirector,
        DoctorPosition.director => l10n.doctorPositionDirector,
      };
}

/// `GenderType` of `Respira.Doctor` (only two values on the wire).
enum DoctorGender {
  male('Male'),
  female('Female');

  const DoctorGender(this.wireValue);

  final String wireValue;

  static DoctorGender? fromWire(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;
    for (final gender in DoctorGender.values) {
      if (gender.wireValue.toLowerCase() == normalized) return gender;
    }
    return null;
  }

  String label(AppLocalizations l10n) => switch (this) {
        DoctorGender.male => l10n.genderMale,
        DoctorGender.female => l10n.genderFemale,
      };
}
