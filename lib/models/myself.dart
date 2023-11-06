import 'package:cloud_firestore/cloud_firestore.dart';

class Myself {
  const Myself({
    required this.about,
    required this.position,
    required this.photo,
    required this.birthDay,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.tools,
  });

  factory Myself.fromMap(Map<String, dynamic> map) {
    return Myself(
      about: map['about'] ?? '',
      position: map['position'] ?? '',
      photo: map['photo'] ?? '',
      birthDay: DateTime.fromMillisecondsSinceEpoch(map['birthDay']),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      tools: List<WorkTool>.from(map['tools']?.map((x) => WorkTool.fromDoc(x))),
    );
  }

  final String about;
  final String address;
  final DateTime birthDay;
  final String email;
  final String name;
  final String phone;
  final String photo;
  final String position;
  final List<WorkTool> tools;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'about': about});
    result.addAll({'position': position});
    result.addAll({'photo': photo});
    result.addAll({'birthDay': birthDay.millisecondsSinceEpoch});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'address': address});
    result.addAll({'tools': tools.map((x) => x.toMap()).toList()});

    return result;
  }
}

class WorkTool {
  const WorkTool({
    required this.name,
    required this.icon,
  });

  factory WorkTool.fromDoc(DocumentSnapshot doc) {
    return WorkTool(
      name: doc['name'] ?? '',
      icon: doc['icon'] ?? '',
    );
  }

  final String icon;
  final String name;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'name': name});
    result.addAll({'icon': icon});

    return result;
  }
}

class Education {
  Education({
    required this.schoolName,
    required this.schoolWebsite,
    required this.startDate,
    required this.graduationDate,
    required this.subject,
    required this.result,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      graduationDate: map['graduationDate'] != null
          ? (map['graduationDate'] as Timestamp).toDate()
          : null,
      result: map['result'] ?? '',
      schoolName: map['schoolName'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      subject: map['subject'] ?? '',
      schoolWebsite: map['schoolWebsite'] ?? '',
    );
  }

  final DateTime? graduationDate;
  final String result;
  final String schoolName;
  final String schoolWebsite;
  final DateTime startDate;
  final String subject;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'graduationDate': graduationDate});
    result.addAll({'result': result});
    result.addAll({'schoolName': schoolName});
    result.addAll({'startDate': startDate});
    result.addAll({'subject': subject});
    result.addAll({'schoolWebsite': schoolWebsite});

    return result;
  }
}

class WorkExperience {
  WorkExperience({
    required this.companyName,
    required this.companyWebsite,
    required this.position,
    required this.sector,
    required this.companyLogo,
    required this.joinDate,
    required this.leaveDate,
  });

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      companyLogo: map['companyLogo'] ?? '',
      companyName: map['companyName'] ?? '',
      companyWebsite: map['companyWebsite'] ?? '',
      joinDate: DateTime.fromMillisecondsSinceEpoch(map['joinDate']),
      leaveDate: map['leaveDate'] != null
          ? (map['leaveDate'] as Timestamp).toDate()
          : null,
      position: map['position'] ?? '',
      sector: map['sector'] ?? '',
    );
  }

  final String companyLogo;
  final String companyName;
  final String companyWebsite;
  final DateTime joinDate;
  final DateTime? leaveDate;
  final String position;
  final String sector;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'companyLogo': companyLogo});
    result.addAll({'companyName': companyName});
    result.addAll({'companyWebsite': companyWebsite});
    result.addAll({'joinDate': joinDate});
    result.addAll({'leaveDate': leaveDate});
    result.addAll({'position': position});
    result.addAll({'sector': sector});

    return result;
  }
}
