enum PermissionEffect { allow, deny }

class PermissionOverride {
  final String permission;
  final PermissionEffect effect;

  const PermissionOverride({
    required this.permission,
    required this.effect,
  });

  factory PermissionOverride.fromJson(Map<String, dynamic> json) {
    final value = json['effect']?.toString().toLowerCase();
    return PermissionOverride(
      permission: json['permission']?.toString() ?? '',
      effect: value == 'deny'
          ? PermissionEffect.deny
          : PermissionEffect.allow,
    );
  }

  Map<String, dynamic> toJson() => {
        'permission': permission,
        'effect': effect.name,
      };
}
