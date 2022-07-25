class AvatarReference {
  AvatarReference(this.imageUrl);
  final String? imageUrl;

  factory AvatarReference.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return AvatarReference("");
    }
    final String imageUrl = data['imageUrl'] ?? "";

    return AvatarReference(imageUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
    };
  }
}
