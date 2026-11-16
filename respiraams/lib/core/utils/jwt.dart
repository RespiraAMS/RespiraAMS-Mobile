import 'dart:convert';

/// Claims decoded from a backend access token.
///
/// .NET serialises `ClaimTypes.*` using short names (`nameid`, `email`,
/// `role`) but the long URI forms can also appear, so both spellings are
/// accepted.
class JwtClaims {
  const JwtClaims({
    this.subject,
    this.email,
    this.role,
  });

  /// `sub` / `nameid` — the authenticated *account* id.
  final String? subject;
  final String? email;
  final String? role;

  /// `sub` or `nameid`, whichever is present.
  String? get accountId => subject;
}

/// Minimal JWT payload reader — decodes (never verifies) the access token
/// so the app can restore the account id, role and email. The gateway
/// verifies the signature.
JwtClaims? decodeJwt(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final map = jsonDecode(payload) as Map<String, dynamic>;
    String? pick(List<String> keys) {
      for (final key in keys) {
        final value = map[key];
        if (value is String && value.isNotEmpty) return value;
      }
      return null;
    }

    return JwtClaims(
      subject: pick(const [
        'sub',
        'nameid',
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier',
        'X-ID',
        'x-id',
      ]),
      email: pick(const [
        'email',
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress',
      ]),
      role: pick(const [
        'role',
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
      ]),
    );
  } on FormatException {
    return null;
  } on TypeError {
    return null;
  }
}

/// Backwards-compatible helper: account id from an access token.
String? doctorIdFromToken(String token) => decodeJwt(token)?.subject;
