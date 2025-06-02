import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:safe_driver_core/models/usuario.dart';

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key, required this.usuario, required this.onPressed});
  final Usuario usuario;
  final ValueChanged<Usuario> onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> onPressed.call(usuario),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: usuario.image == null ? null : CachedNetworkImageProvider(usuario.image!),
        child: usuario.image == null ? const Icon(Ionicons.person_outline) : null,
      ),
      title: Text(
        usuario.username!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: const Text("Ver Perfil"),
    );
  }
}