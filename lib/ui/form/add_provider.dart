import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';
import 'package:flutter/material.dart';

class AddFormProvider extends ChangeNotifier {
  AddFormProvider({
    required this.formRepository,
    this.formData,
  });
  final FormRepository formRepository;
  final FormModel? formData;
  Future<void> add(FormModel newForm) async {
    if (formData != null) {
      await formRepository.updateForm(newForm.copyWith(id: formData!.id));
    } else {
      await formRepository.addForm(newForm);
    }
  }
}
