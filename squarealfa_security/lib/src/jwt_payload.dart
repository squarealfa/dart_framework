/// Represents the payload content of a JWT token.
class JwtPayload {
  final String subject;
  final String username;
  final String name;
  final String issuer;
  final String audience;
  final DateTime notBefore;
  final DateTime expires;
  

  /// any other extra fields that are
  /// not represented in the available properties
  /// are stored in this property.
  final Map<String, dynamic> extra;

  const JwtPayload({
    required this.subject,
    required this.username,
    required this.name,
    required this.issuer,
    required this.audience,
    required this.notBefore,
    required this.expires,
    this.extra = const <String, dynamic>{},
  });

  factory JwtPayload.fromMap(Map<String, dynamic> map) {
    var name = '';
    var subject = '';
    var username = '';
    var issuer = '';
    var audience = '';
    var nbf = DateTime.now();
    var exp = DateTime.now();
    var extra = <String, dynamic>{};

    for (var entry in map.entries) {
      switch (entry.key) {
        case 'name':
          name = entry.value;
          break;
        case 'sub':
          subject = entry.value;
          break;
        case 'username':
          username = entry.value;
          break;
        case 'iss':
          issuer = entry.value;
          break;
        case 'aud':
          audience = entry.value;
          break;
        case 'nbf':
          nbf = _getDateTime(entry.value);
          break;
        case 'exp':
          exp = _getDateTime(entry.value);
          break;
        default:
          extra[entry.key] = entry.value;
          break;
      }
    }

    var payload = JwtPayload(
      name: name,
      subject: subject,
      username: username,
      issuer: issuer,
      audience: audience,
      notBefore: nbf,
      expires: exp,
      extra: extra,
    );
    return payload;
  }

  JwtPayload CopyWith({
    String? subject,
    String? username,
    String? name,
    String? issuer,
    String? audience,
    DateTime? notBefore,
    DateTime? expires,
    String? userId,
    String? tenantId,
    List<String>? roles,
    Map<String, dynamic>? extra,
  }) {
    var ret = JwtPayload(
      subject: subject ?? this.subject,
      username: username ?? this.username,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      audience: audience ?? this.audience,
      notBefore: notBefore ?? this.notBefore,
      expires: expires ?? this.expires,
      extra: extra ?? this.extra,
    );
    return ret;
  }

  Map<String, dynamic> get claimsMap {
    var nbf = _getEpochSeconds(notBefore);
    var exp = _getEpochSeconds(expires);

    var map = <String, dynamic>{};
    _addClaimIfNotNull(map, 'name', name);
    _addClaimIfNotNull(map, 'sub', subject);
    _addClaimIfNotNull(map, 'username', username);
    _addClaimIfNotNull(map, 'iss', issuer);
    _addClaimIfNotNull(map, 'aud', audience);
    _addClaimIfNotNull(map, 'nbf', nbf);
    _addClaimIfNotNull(map, 'exp', exp);
    for (var claim in extra.entries) {
      _addClaimIfNotNull(map, claim.key, claim.value);
    }

    return map;
  }

  static String? _getEpochSeconds(DateTime? value) =>
      value == null ? null : (value.millisecondsSinceEpoch ~/ 1000).toString();

  static DateTime _getDateTime(String secondsAsString) {
    var seconds = int.parse(secondsAsString);
    var dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return dt;
  }

  static void _addClaimIfNotNull(
    Map<String, dynamic> claimsMap,
    String? claim,
    dynamic value,
  ) {
    if (claim != null) claimsMap[claim] = value;
  }
}
