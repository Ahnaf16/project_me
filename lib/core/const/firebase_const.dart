class FirePath {
  const FirePath._();

  static const String users = 'users';
  static const String cards = 'cards';
  static const String appConfig = 'appConfig';
  static const String urlsDoc = 'urls';
}

class FireDefaults {
  static const String defaultPhoto =
      'https://firebasestorage.googleapis.com/v0/b/marj-card.appspot.com/o/default%2Fuser-def-dp.png?alt=media&token=b4d88616-094c-4eab-bd79-a54b86b2dc0f';
}

class StoragePath {
  const StoragePath._();

  static const String socialIcons = 'social_icons';
  static String user(uid) => 'users/$uid';
  static String userProfile(uid) => '${user(uid)}/profile';
  static String userCover(uid) => '${user(uid)}/cover';
  static String userGallery(uid) => '${user(uid)}/gallery';
  static String userSocialIcons(uid) => '${user(uid)}/icons';
}

class StorageFileNames {
  const StorageFileNames._();

  static const String mainProfile = 'main_profile.jpeg';
  static String profile(String cardId) => 'profile_$cardId.jpeg';
  static String cover(String cardId) => 'cover_$cardId.jpeg';
  static String galleries(int index, String cardId) =>
      'gallery_${cardId}_{$index}.jpeg';
  static String icons(String url, String cardId) => 'icon_${url}_$cardId.jpeg';
}
