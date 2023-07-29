String greetWithName(String name) {
  if (name.isEmpty) {
    return 'Hola 👋';
  }

  List<String> nameParts = name.split(' ');

  if (nameParts.length == 1) {
    return 'Hola ${nameParts[0]} 👋';
  } else if (nameParts.length == 2) {
    String firstName = nameParts[0];
    String lastName = nameParts[1];
    String lastNameInitial = lastName.substring(0, 1).toUpperCase();
    return 'Hola $firstName $lastNameInitial. 👋';
  } else if (nameParts.length == 3 || nameParts.length == 4) {
    String firstName = nameParts[0];
    String lastName = nameParts[nameParts.length - 2];
    String lastNameInitial = lastName.substring(0, 1).toUpperCase();
    return 'Hola $firstName $lastNameInitial. 👋';
  } else {
    return 'Nombre inválido';
  }
}
