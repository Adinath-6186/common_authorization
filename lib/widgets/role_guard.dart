import 'package:flutter/widgets.dart';
import '../core/authorization_service.dart';

class RoleGuard extends StatelessWidget {
  final AuthorizationService authorization;
  final String role;
  final Widget child;
  final Widget? fallback;

  const RoleGuard({
    super.key,
    required this.authorization,
    required this.role,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return authorization.hasRole(role)
        ? child
        : (fallback ?? const SizedBox.shrink());
  }
}
