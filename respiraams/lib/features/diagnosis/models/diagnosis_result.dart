/// Tabs of the diagnosis-result screen.
enum DiagnosisTab {
  result('Kết quả'),
  suspected('Căn nguyên'),
  evidences('Bằng chứng');

  const DiagnosisTab(this.label);

  final String label;
}
