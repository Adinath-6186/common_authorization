import 'app_user.dart';

class AuthorizationContext {
  final AppUser? user;

  final Set<String> permissions;
  final Set<String> roles;

  const AuthorizationContext({
    this.user,
    this.permissions = const {},
    this.roles = const {},
  });

  bool get isAuthenticated => user != null;

  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  bool hasAnyPermission(Iterable<String> values) {
    return values.any(permissions.contains);
  }

  bool hasAllPermissions(Iterable<String> values) {
    return values.every(permissions.contains);
  }

  bool hasRole(String role) {
    return roles.contains(role);
  }

  bool hasAnyRole(Iterable<String> values) {
    return values.any(roles.contains);
  }

  bool hasAllRoles(Iterable<String> values) {
    return values.every(roles.contains);
  }
}
