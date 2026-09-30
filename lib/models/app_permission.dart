class AppPermission {
  final String code;
  final String name;
  final String? module;
  final String? description;

  const AppPermission({
    required this.code,
    required this.name,
    this.module,
    this.description,
  });

  factory AppPermission.fromJson(Map<String, dynamic> json) {
    return AppPermission(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      module: json['module']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        if (module != null) 'module': module,
        if (description != null) 'description': description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPermission && other.code == code;

  @override
  int get hashCode => code.hashCode;
}
