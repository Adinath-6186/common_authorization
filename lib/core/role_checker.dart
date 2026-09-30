class RoleChecker {
  const RoleChecker();

  bool has(Set<String> roles, String role) => roles.contains(role);

  bool hasAny(Set<String> roles, Iterable<String> required) =>
      required.any(roles.contains);

  bool hasAll(Set<String> roles, Iterable<String> required) =>
      required.every(roles.contains);
}
