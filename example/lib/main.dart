import 'package:flutter/material.dart';
import 'package:common_authorization/common_authorization.dart';

abstract final class PharmacyPermissions {
  static const medicineView = 'medicine.view';
  static const medicineCreate = 'medicine.create';
  static const medicineEdit = 'medicine.edit';
  static const medicineDelete = 'medicine.delete';
}

void main() {
  final authorization = AuthorizationService();

  authorization.setUser(
    const AppUser(
      id: '1',
      name: 'Demo Admin',
      roles: [
        AppRole(id: '1', code: 'ADMIN', name: 'Administrator'),
      ],
      permissions: [
        AppPermission(
          code: PharmacyPermissions.medicineView,
          name: 'View Medicine',
          module: 'inventory',
        ),
        AppPermission(
          code: PharmacyPermissions.medicineEdit,
          name: 'Edit Medicine',
          module: 'inventory',
        ),
      ],
    ),
  );

  runApp(DemoApp(authorization: authorization));
}

class DemoApp extends StatelessWidget {
  final AuthorizationService authorization;

  const DemoApp({super.key, required this.authorization});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authorization Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Authorization Demo')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('User: ${authorization.user?.name ?? '-'}'),
            const SizedBox(height: 16),
            PermissionGuard(
              authorization: authorization,
              permission: PharmacyPermissions.medicineView,
              child: const ListTile(
                leading: Icon(Icons.visibility),
                title: Text('View Medicine'),
              ),
            ),
            PermissionGuard(
              authorization: authorization,
              permission: PharmacyPermissions.medicineEdit,
              child: const ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Medicine'),
              ),
            ),
            PermissionGuard(
              authorization: authorization,
              permission: PharmacyPermissions.medicineDelete,
              fallback: const ListTile(
                leading: Icon(Icons.lock),
                title: Text('Delete Medicine - No Permission'),
              ),
              child: const ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete Medicine'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
