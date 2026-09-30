import 'package:flutter/widgets.dart';
import '../core/authorization_service.dart';

class PermissionBuilder extends StatelessWidget {
  final AuthorizationService authorization;
  final String permission;
  final WidgetBuilder builder;
  final WidgetBuilder? fallback;

  const PermissionBuilder({
    super.key,
    required this.authorization,
    required this.permission,
    required this.builder,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    if (authorization.hasPermission(permission)) {
      return builder(context);
    }
    return fallback?.call(context) ?? const SizedBox.shrink();
  }
}
