# common_authorization

A reusable Flutter authorization package for applications that need a common user, role, permission, and authorization model.

## What it provides

- `AppUser`
- `AppRole`
- `AppPermission`
- `PermissionOverride`
- `AuthorizationState`
- `AuthorizationService`
- Permission and role checks
- `PermissionGuard`
- `PermissionBuilder`
- `RoleGuard`
- Storage abstraction
- In-memory storage implementation
- Unit tests
- Example Flutter integration

## Architecture

The package intentionally does **not** own HTTP/API code, login screens, Dio, Retrofit, Provider, Riverpod, Bloc, or project-specific permissions.

Each application owns:

1. Login/API calls
2. Repository implementation
3. Backend response mapping
4. Project-specific permission constants
5. Business logic

The package owns:

1. Common authorization models
2. Authorization state
3. Permission checking
4. Role checking
5. Permission overrides
6. Reusable authorization widgets
7. Storage abstraction

## Add to a project during development

```yaml
dependencies:
  common_authorization:
    path: ../common_authorization
```

Or use a Git repository:

```yaml
dependencies:
  common_authorization:
    git:
      url: git@github.com:your-company/common_authorization.git
      ref: v1.0.0
```

## Basic usage

```dart
final authorization = AuthorizationService();

final user = AppUser(
  id: '101',
  name: 'Adinath',
  roles: const [
    AppRole(
      id: '1',
      code: 'ADMIN',
      name: 'Administrator',
    ),
  ],
  permissions: const [
    AppPermission(
      code: 'medicine.view',
      name: 'View Medicine',
    ),
    AppPermission(
      code: 'medicine.edit',
      name: 'Edit Medicine',
    ),
  ],
);

authorization.setUser(user);
```

Check permission:

```dart
if (authorization.hasPermission('medicine.edit')) {
  // allowed
}
```

Check multiple permissions:

```dart
final canManageMedicine = authorization.hasAllPermissions([
  'medicine.view',
  'medicine.edit',
]);
```

Check any permission:

```dart
final canOpenMedicine = authorization.hasAnyPermission([
  'medicine.view',
  'medicine.manage',
]);
```

## UI guard

```dart
PermissionGuard(
  authorization: authorization,
  permission: 'medicine.edit',
  child: EditMedicineButton(),
)
```

With fallback:

```dart
PermissionGuard(
  authorization: authorization,
  permission: 'medicine.delete',
  fallback: const Text('You do not have permission.'),
  child: DeleteMedicineButton(),
)
```

## Project-specific permission definitions

Do not put Pharmacy, Clinic, CRM, or other project permissions inside this package.

Example Pharmacy project:

```dart
abstract final class PharmacyPermissions {
  static const medicineView = 'medicine.view';
  static const medicineCreate = 'medicine.create';
  static const medicineEdit = 'medicine.edit';
  static const medicineDelete = 'medicine.delete';
}
```

Example Clinic project:

```dart
abstract final class ClinicPermissions {
  static const patientView = 'patient.view';
  static const patientCreate = 'patient.create';
  static const patientEdit = 'patient.edit';
  static const appointmentCreate = 'appointment.create';
}
```

## Backend security

Flutter authorization is a UI/client-side authorization layer. It must not be treated as the security boundary.

The backend must authenticate the request and check the same permission before performing protected operations.

Recommended flow:

```text
Login
  -> API
  -> user + roles + permissions
  -> project repository
  -> AuthorizationService
  -> UI permission checks
  -> protected API request
  -> backend authorization check
  -> database
```

## Versioning

Use semantic versions for the package:

- `1.0.0` initial stable API
- `1.1.0` backward-compatible features
- `2.0.0` breaking changes

Pin production applications to a known package version/tag.
