import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context) async {
  final confirm = await showDialog<bool?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirma a remoção?'),
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Theme.of(context).colorScheme.error,
        ),
        content: const Text(
          'Tem certeza que deseja remover este item? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Remover',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      );
    },
  );

  return confirm == true;
}
