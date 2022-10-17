import 'package:crud_firebase/data/form_firebase.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';
import 'package:crud_firebase/ui/form/add_form_screen.dart';
import 'package:crud_firebase/ui/form/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FormRepository>(
          create: (_) => FormFirebase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'AirbnbCereal',
        ),
        home: MyForms(),
      ),
    );
  }
}

class MyForms extends StatefulWidget {
  MyForms({Key? key}) : super(key: key);

  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formularios', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text('Agregar Formulario'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddFormScreen.init(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Formularios creados'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomeListScreen.init(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
