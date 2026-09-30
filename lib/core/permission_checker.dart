class PermissionChecker {
  const PermissionChecker();

  bool has(Set<String> permissions, String permission) =>
      permissions.contains(permission);

  bool hasAny(Set<String> permissions, Iterable<String> required) =>
      required.any(permissions.contains);

  bool hasAll(Set<String> permissions, Iterable<String> required) =>
      required.every(permissions.contains);
}
