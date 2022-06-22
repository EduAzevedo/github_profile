class User {
  final String name;
  final String avatarUrl;
  final String blog;
  final String bio;
  final String location;
  final String created_at;
  final String url;
  final int followers;
  final int following;
  final int publicRepos;

  User(
    this.name,
    this.avatarUrl,
    this.blog,
    this.followers,
    this.following,
    this.publicRepos,
    this.bio,
    this.location,
    this.created_at,
    this.url,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'],
      json['avatar_url'],
      json['blog'],
      json['followers'],
      json['following'],
      json['public_repos'],
      json['bio'],
      json['location'],
      json['created_at'],
      json['html_url'],
    );
  }
}
