import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';
import '../visitor.dart';
import 'files_dialog.dart';
import 'files_visitor_selection.dart';

class VisitorExample extends StatefulWidget {
  const VisitorExample();

  @override
  _VisitorExampleState createState() => _VisitorExampleState();
}

class _VisitorExampleState extends State<VisitorExample> {
  final List<IVisitor> visitorsList = [
    HumanReadableVisitor(),
    XmlVisitor(),
  ];

  late final IFile _rootDirectory;
  int _selectedVisitorIndex = 0;

  @override
  void initState() {
    super.initState();

    _rootDirectory = _buildMediaDirectory();
  }

  IFile _buildMediaDirectory() {
    final musicDirectory = Directory(
      title: 'Music',
      level: 1,
    );
    musicDirectory.addFile(
      const AudioFile(
        title: 'Darude - Sandstorm',
        albumTitle: 'Before the Storm',
        fileExtension: 'mp3',
        size: 2612453,
      ),
    );
    musicDirectory.addFile(
      const AudioFile(
        title: 'Toto - Africa',
        albumTitle: 'Toto IV',
        fileExtension: 'mp3',
        size: 3219811,
      ),
    );
    musicDirectory.addFile(
      const AudioFile(
        title: 'Bag Raiders - Shooting Stars',
        albumTitle: 'Bag Raiders',
        fileExtension: 'mp3',
        size: 3811214,
      ),
    );

    final moviesDirectory = Directory(
      title: 'Movies',
      level: 1,
    );
    moviesDirectory.addFile(
      const VideoFile(
        title: 'The Matrix',
        directedBy: 'The Wachowskis',
        fileExtension: 'avi',
        size: 951495532,
      ),
    );
    moviesDirectory.addFile(
      const VideoFile(
        title: 'Pulp Fiction',
        directedBy: 'Quentin Tarantino',
        fileExtension: 'mp4',
        size: 1251495532,
      ),
    );

    final catPicturesDirectory = Directory(
      title: 'Cats',
      level: 2,
    );
    catPicturesDirectory.addFile(
      const ImageFile(
        title: 'Cat 1',
        resolution: '640x480px',
        fileExtension: 'jpg',
        size: 844497,
      ),
    );
    catPicturesDirectory.addFile(
      const ImageFile(
        title: 'Cat 2',
        resolution: '1280x720px',
        fileExtension: 'jpg',
        size: 975363,
      ),
    );
    catPicturesDirectory.addFile(
      const ImageFile(
        title: 'Cat 3',
        resolution: '1920x1080px',
        fileExtension: 'png',
        size: 1975363,
      ),
    );

    final picturesDirectory = Directory(
      title: 'Pictures',
      level: 1,
    );
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(
      const ImageFile(
        title: 'Not a cat',
        resolution: '2560x1440px',
        fileExtension: 'png',
        size: 2971361,
      ),
    );

    final mediaDirectory = Directory(
      title: 'Media',
      level: 0,
      isInitiallyExpanded: true,
    );
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(
      Directory(
        title: 'New Folder',
        level: 1,
      ),
    );
    mediaDirectory.addFile(
      const TextFile(
        title: 'Nothing suspicious there',
        content: 'Just a normal text file without any sensitive information.',
        fileExtension: 'txt',
        size: 430791,
      ),
    );
    mediaDirectory.addFile(
      const TextFile(
        title: 'TeamTrees',
        content:
            'Team Trees, also known as #teamtrees, is a collaborative fundraiser that managed to raise 20 million U.S. dollars before 2020 to plant 20 million trees.',
        fileExtension: 'txt',
        size: 1042,
      ),
    );

    return mediaDirectory;
  }

  void _setSelectedVisitorIndex(int? index) {
    setState(() {
      _selectedVisitorIndex = index!;
    });
  }

  void _showFilesDialog() {
    final selectedVisitor = visitorsList[_selectedVisitorIndex];
    final filesText = _rootDirectory.accept(selectedVisitor);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FilesDialog(
        filesText: filesText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: [
            FilesVisitorSelection(
              visitorsList: visitorsList,
              selectedIndex: _selectedVisitorIndex,
              onChanged: _setSelectedVisitorIndex,
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _showFilesDialog,
              text: 'Export files',
            ),
            const SizedBox(height: 12),
            _rootDirectory.render(context),
          ],
        ),
      ),
    );
  }
}
