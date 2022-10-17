import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';

class FormFirebase implements FormRepository {
  final formRef =
      FirebaseFirestore.instance.collection('forms').withConverter<FormModel>(
            fromFirestore: (snapshots, _) {
              final form = FormModel.fromJson(snapshots.data()!);
              final newForm = form.copyWith(id: snapshots.id);
              return newForm;
            },
            toFirestore: (form, _) => form.toJson(),
          );

  @override
  Future<List<FormModel>> getForms() async {
    final querySnapshot = await formRef.get();
    final forms = querySnapshot.docs.map((e) => e.data()).toList();
    return forms;
  }

  @override
  Future<FormModel> addForm(FormModel form) async {
    final result = await formRef.add(form);
    return form.copyWith(id: result.id);
  }

  @override
  Future<bool> deleteForm(String id) async {
    await formRef.doc(id).delete();
    return true;
  }

  @override
  Future<FormModel> updateForm(FormModel form) async {
    await formRef.doc(form.id).update(form.toJson());
    return form;
  }

  @override
  Stream<List<FormModel>> getFormsStream() {
    final result = formRef.snapshots().map(
          (event) => event.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    return result;
  }
}
