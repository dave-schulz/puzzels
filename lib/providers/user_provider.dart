import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  const UserProfile({required this.displayName});

  final String displayName;
}

final userProfileProvider = Provider<UserProfile>(
  (ref) => const UserProfile(displayName: 'Davey'),
);
