import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/editar_usuario_page.dart';
import 'package:farmastock/widgets/components/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  @override
  void initState() {
    usuariosBox.listenable().addListener(onBoxChanged);
    super.initState();
  }

  @override
  void dispose() {
    usuariosBox.listenable().removeListener(onBoxChanged);
    super.dispose();
  }

  void onBoxChanged() {
    setState(() {});
  }

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
              itemCount: usuariosBox.values.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final usuario = usuariosBox.values.elementAt(index);

                return ListTile(
                  title: Text(usuario.nome),
                  subtitle: Text(usuario.email),
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      if (usuario.role == UsuarioRole.admin)
                        Badge(
                          label: Text('Admin'),
                          backgroundColor: Colors.green,
                        ),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                        tooltip: 'Editar',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditarUsuarioPage(usuario: usuario);
                              },
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        tooltip: 'Excluir',
                        onPressed: () async {
                          bool confirmado = await confirmDialog(context);
                          if (!confirmado) return;
                          await usuariosBox.delete(usuario.id);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Usuário "${usuario.nome}" excluído',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditarUsuarioPage()),
          );
        },
        tooltip: 'Adicionar Usuário',
        child: const Icon(Icons.add),
      ),
    );
  }
}
