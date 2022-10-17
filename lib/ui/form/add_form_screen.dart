// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';
import 'package:crud_firebase/ui/form/add_provider.dart';

import 'package:crud_firebase/ui/common/button/button_widget.dart';
import 'package:crud_firebase/ui/common/input/input_widget.dart';

class AddFormScreen extends StatefulWidget {
  const AddFormScreen._();

  static Widget init({FormModel? form}) => ChangeNotifierProvider(
        lazy: false,
        create: (context) => AddFormProvider(
          formRepository: context.read<FormRepository>(),
          formData: form,
        ),
        child: const AddFormScreen._(),
      );
  @override
  State<AddFormScreen> createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final _controllerName = TextEditingController();
  final _controllerAge = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerStreet = TextEditingController();
  final _controllerZip = TextEditingController();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> _loadInit() async {
    final form = context.read<AddFormProvider>().formData;
    if (form != null) {
      _controllerName.text = form.name!;
      _controllerAge.text = form.age!;
      _controllerEmail.text = form.email!;
      _controllerPhone.text = form.phone!;
      _controllerAddress.text = form.address!;
      _controllerStreet.text = form.street!;
      _controllerZip.text = form.zip!;
    }
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  Future<void> exportImage(BuildContext context) async {
    final firebaseStorage = FirebaseStorage.instance;

    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No content')));
      return;
    }

    final Uint8List? data = await _controller.toPngBytes();
    if (data == null) {
      return;
    }

    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(data);
//Upload to Firebase
    var snapshot = await firebaseStorage
        .ref()
        .child('signatures/${file.path.split('/').last}')
        .putFile(file)
        .whenComplete(() => {
              file.delete(),
            });

    var downloadUrl = await snapshot.ref.getDownloadURL();

    final newForm = FormModel(
      name: _controllerName.text,
      age: _controllerAge.text,
      email: _controllerEmail.text,
      phone: _controllerPhone.text,
      address: _controllerAddress.text,
      street: _controllerStreet.text,
      zip: _controllerZip.text,
      signature: downloadUrl,
    );
    context.read<AddFormProvider>().add(newForm);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Success',
      desc: 'This form has been added',
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Nuevo formulario',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              InputWidget(label: 'Nombre', controller: _controllerName),
              const SizedBox(height: 16),
              InputWidget(label: 'Edad', controller: _controllerAge),
              const SizedBox(height: 16),
              InputWidget(label: 'Email', controller: _controllerEmail),
              const SizedBox(height: 16),
              InputWidget(label: 'Teléfono', controller: _controllerPhone),
              const SizedBox(height: 16),
              InputWidget(label: 'Dirección', controller: _controllerAddress),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InputWidget(
                      label: 'C.P',
                      controller: _controllerZip,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InputWidget(
                      label: 'Ciudad',
                      controller: _controllerStreet,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              // Signature Container
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/sending.png',
                      height: 170,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Para terminar, agrega tu firma digital',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ahora puede firmar este formulario y enviarlo al administrador',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 190,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Signature(
                  controller: _controller,
                  height: 300,
                  backgroundColor: Colors.white,
                  key:
                      null, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
                ),
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                onPressed: () {
                  exportImage(context);
                  print('Send');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
