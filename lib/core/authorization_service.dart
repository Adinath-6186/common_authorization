import '../models/app_user.dart';
import '../models/authorization_state.dart';
import '../models/permission_override.dart';
import '../mappers/authorization_mapper.dart';

class AuthorizationService {
  AuthorizationState _state = const AuthorizationState();

  AuthorizationState get state => _state;
  AppUser? get user => _state.user;
  bool get isAuthenticated => _state.isAuthenticated;
  Set<String> get permissions => Set.unmodifiable(_state.permissions);
  Set<String> get roles => Set.unmodifiable(_state.roles);


  void setMappedUser<T>(T response, AuthorizationMapper<T> mapper) {
    final user = mapper.mapUser(response);
    setUser(user);
  }
  
  void setUser(AppUser user) {
    final permissionSet = user.permissions.map((e) => e.code).toSet();

    for (final override in user.overrides) {
      if (override.effect == PermissionEffect.allow) {
        permissionSet.add(override.permission);
      } else {
        permissionSet.remove(override.permission);
      }
    }

    _state = AuthorizationState(
      user: user,
      permissions: permissionSet,
      roles: user.roles.map((e) => e.code).toSet(),
      isAuthenticated: true,
    );
  }

  void setPermissions(Iterable<String> permissions) {
    _state = _state.copyWith(
      permissions: permissions.toSet(),
      isAuthenticated: true,
    );
  }

  void setRoles(Iterable<String> roles) {
    _state = _state.copyWith(
      roles: roles.toSet(),
      isAuthenticated: true,
    );
  }

  bool hasPermission(String permission) =>
      _state.hasPermission(permission);

  bool hasAnyPermission(Iterable<String> permissions) =>
      _state.hasAnyPermission(permissions);

  bool hasAllPermissions(Iterable<String> permissions) =>
      _state.hasAllPermissions(permissions);

  bool hasRole(String role) => _state.hasRole(role);

  bool hasAnyRole(Iterable<String> roles) =>
      roles.any(_state.hasRole);

  bool hasAllRoles(Iterable<String> roles) =>
      roles.every(_state.hasRole);

  void clear() {
    _state = const AuthorizationState();
  }
}
