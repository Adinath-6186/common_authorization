import 'app_permission.dart';
import 'app_role.dart';
import 'permission_override.dart';

class AppUser {
  final String id;
  final String? name;
  final String? email;
  final String? mobile;
  final bool isActive;
  final List<AppRole> roles;
  final List<AppPermission> permissions;
  final List<PermissionOverride> overrides;

  const AppUser({
    required this.id,
    this.name,
    this.email,
    this.mobile,
    this.isActive = true,
    this.roles = const [],
    this.permissions = const [],
    this.overrides = const [],
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final rolesJson = (json['roles'] as List?) ?? const [];
    final permissionsJson = (json['permissions'] as List?) ?? const [];
    final overridesJson = (json['overrides'] as List?) ?? const [];

    return AppUser(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      mobile: json['mobile']?.toString(),
      isActive: json['isActive'] as bool? ?? true,
      roles: rolesJson
          .whereType<Map>()
          .map((e) => AppRole.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      permissions: permissionsJson
          .whereType<Map>()
          .map((e) => AppPermission.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      overrides: overridesJson
          .whereType<Map>()
          .map((e) => PermissionOverride.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (mobile != null) 'mobile': mobile,
        'isActive': isActive,
        'roles': roles.map((e) => e.toJson()).toList(),
        'permissions': permissions.map((e) => e.toJson()).toList(),
        'overrides': overrides.map((e) => e.toJson()).toList(),
      };
}
