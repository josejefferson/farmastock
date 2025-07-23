import 'package:farmastock/constants/usuarios.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Gerencie os usuários que têm acesso ao sistema'),
            ),

            SizedBox(height: 8.0),

            ListView.builder(
              itemCount: usuarios.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usuarios[index].nome),
                  subtitle: Text(usuarios[index].email),
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      if (usuarios[index].isAdmin)
                        Badge(
                          label: Text('Admin'),
                          backgroundColor: Colors.green,
                        ),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                        tooltip: 'Editar',
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        tooltip: 'Excluir',
                        onPressed: () {},
                      ),
                    ],
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
