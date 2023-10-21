class Project {
  const Project({
    required this.name,
    required this.description,
    required this.icon,
    required this.covers,
    required this.hostUrl,
    required this.source,
    required this.startDate,
    required this.contributors,
  });

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      contributors: List<Contributor>.from(
          map['contributors']?.map((x) => Contributor.fromMap(x))),
      covers: List<String>.from(map['covers']),
      description: map['description'] ?? '',
      hostUrl: map['hostUrl'] ?? '',
      icon: map['icon'] ?? '',
      name: map['name'] ?? '',
      source: map['source'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
    );
  }

  final List<Contributor> contributors;
  final List<String> covers;
  final String description;
  final String hostUrl;
  final String icon;
  final String name;
  final String source;
  final DateTime startDate;
}

class Contributor {
  Contributor({
    required this.name,
    required this.photo,
    required this.gitHubProfile,
  });

  factory Contributor.fromMap(Map<String, dynamic> map) {
    return Contributor(
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
      gitHubProfile: map['gitHubProfile'] ?? '',
    );
  }

  final String gitHubProfile;
  final String name;
  final String photo;
}
