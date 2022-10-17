import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:flutter/material.dart';

class AddProvider extends ChangeNotifier {
  AddProvider({
    required this.personRepository,
    this.person,
  });

  final PersonRepository personRepository;
  final Person? person;

  Future<Person> add(Person newPerson) async {
    Person? result;
    if (person != null) {
      result = await personRepository
          .updatePerson(newPerson.copyWith(id: person!.id));
    } else {
      result = await personRepository.addPerson(newPerson);
    }
    return result;
  }
}
