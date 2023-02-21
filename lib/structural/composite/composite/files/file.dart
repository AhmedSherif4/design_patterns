import 'package:flutter/material.dart';

import '../../ifile.dart';



class File extends StatelessWidget implements IFile {
  final String title;
  final int size;
  final IconData icon;

  const File({super.key, 
    required this.title,
    required this.size,
    required this.icon,
  });

  @override
  int getSize() {
    return size;
  }

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black54),
        ),
        dense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render(context);
  }
}
class FileSizeConverter {
  const FileSizeConverter._();

  static String bytesToString(int bytes) {
    final sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    double len = bytes.toDouble();
    int order = 0;

    while (len >= 1024 && order++ < sizes.length - 1) {
      len /= 1024;
    }

    return '${len.toStringAsFixed(2)} ${sizes[order]}';
  }
}
