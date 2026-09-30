import 'app_permission.dart';
import 'app_role.dart';
import 'app_user.dart';

class AuthorizationState {
  final AppUser? user;
  final Set<String> permissions;
  final Set<String> roles;
  final bool isAuthenticated;

  const AuthorizationState({
    this.user,
    this.permissions = const <String>{},
    this.roles = const <String>{},
    this.isAuthenticated = false,
  });

  factory AuthorizationState.fromUser(AppUser user) {
    return AuthorizationState(
      user: user,
      permissions: user.permissions.map((e) => e.code).toSet(),
      roles: user.roles.map((e) => e.code).toSet(),
      isAuthenticated: true,
    );
  }

  AuthorizationState copyWith({
    AppUser? user,
    Set<String>? permissions,
    Set<String>? roles,
    bool? isAuthenticated,
  }) {
    return AuthorizationState(
      user: user ?? this.user,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  bool hasPermission(String permission) => permissions.contains(permission);
  bool hasRole(String role) => roles.contains(role);

  bool hasAnyPermission(Iterable<String> values) =>
      values.any(permissions.contains);

  bool hasAllPermissions(Iterable<String> values) =>
      values.every(permissions.contains);
}
