class Repo {
  final String name;
  final String? description;

  Repo({required this.name, this.description});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'] != null ? json['name'].toString() : '',
      description: json['description'] != null ? json['description'].toString() : "",
    );
  }

  @override
  String toString() {
    return 'Repo(name: $name, description: $description)';
  }
}