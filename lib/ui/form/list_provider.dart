import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';
import 'package:flutter/material.dart';

class ListFormProvider extends ChangeNotifier {
  ListFormProvider({required this.formRepository});
  final FormRepository formRepository;
  Stream<List<FormModel>> load() => formRepository.getFormsStream();
  void delete(String docId) async {
    await formRepository.deleteForm(docId);
  }
}
