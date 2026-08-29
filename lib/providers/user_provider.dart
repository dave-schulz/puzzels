import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/local_user.dart';

final currentUserIdProvider = Provider<String>((ref) => localUserId);

class UserProfile {
  const UserProfile({required this.displayName});

  final String displayName;
}

class UserProfileNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() => const UserProfile(displayName: defaultDisplayName);

  void restore(String displayName) {
    state = UserProfile(displayName: displayName);
  }
}

final userProfileProvider =
    NotifierProvider<UserProfileNotifier, UserProfile>(UserProfileNotifier.new);
