import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/domain/repository/form_repository.dart';
import 'package:crud_firebase/ui/common/form-item/form-item.dart';
import 'package:crud_firebase/ui/form/add_form_screen.dart';
import 'package:crud_firebase/ui/form/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeListScreen extends StatefulWidget {
  const HomeListScreen._();
  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => ListFormProvider(
          formRepository: context.read<FormRepository>(),
        )..load(),
        child: const HomeListScreen._(),
      );

  @override
  State<HomeListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Forms',
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
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<FormModel>>(
        stream: context.read<ListFormProvider>().load(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(
              child: Text('Empty list'),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final form = data[index];
              return FormItem(form: form);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddFormScreen.init(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
