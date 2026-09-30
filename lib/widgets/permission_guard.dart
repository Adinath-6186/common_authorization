import 'package:flutter/widgets.dart';
import '../core/authorization_service.dart';

class PermissionGuard extends StatelessWidget {
  final AuthorizationService authorization;
  final String permission;
  final Widget child;
  final Widget? fallback;

  const PermissionGuard({
    super.key,
    required this.authorization,
    required this.permission,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return authorization.hasPermission(permission)
        ? child
        : (fallback ?? const SizedBox.shrink());
  }
}
