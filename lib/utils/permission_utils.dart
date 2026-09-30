abstract final class PermissionUtils {
  static String makeCode({
    required String module,
    required String resource,
    required String action,
  }) {
    return '$module.$resource.$action';
  }
}
