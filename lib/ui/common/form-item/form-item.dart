import 'package:crud_firebase/domain/models/form.dart';
import 'package:crud_firebase/ui/form/add_form_screen.dart';
import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  FormItem({Key? key, required this.form}) : super(key: key);
  FormModel form;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (() {
        print('long press');
      }),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddFormScreen.init(form: form),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(form.name ?? ''),
            subtitle: Text(form.address ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: 30,
              onPressed: () {
                // context.read<FormRepository>().delete(form.id);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddFormScreen.init(form: form),
                  ),
                );
              },
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(form.signature ?? ''),
              radius: 32,
            ),
          ),
        ),
      ),
    );
  }
}
