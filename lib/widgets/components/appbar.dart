import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = usuarioLogadoBox.get('usuarioLogado');
    final nomeUsuario = usuarioLogado?.nome ?? '?';
    final letraUsuario = nomeUsuario[0].toUpperCase();

    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.medication,
            size: 25,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          const Text(
            "FarmaStock",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: PopupMenuButton<String>(
            tooltip: nomeUsuario,
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sair'),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'logout') {
                usuarioLogadoBox.delete('usuarioLogado');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(letraUsuario, style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
