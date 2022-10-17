import 'package:crud_firebase/domain/models/form.dart';

abstract class FormRepository {
  Future<List<FormModel>> getForms();
  Stream<List<FormModel>> getFormsStream();
  Future<FormModel> addForm(FormModel form);
  Future<FormModel> updateForm(FormModel form);
  Future<bool> deleteForm(String id);
}
