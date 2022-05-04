class Usuario {
  final int id;
  final String email;
  final String? displayName;

  Usuario(this.id, this.email, this.displayName);

  @override
  String toString() {
    return 'Usuario{id: $id, email: $email, display_name: $displayName}';
  }
}
