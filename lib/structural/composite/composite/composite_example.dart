import 'package:flutter/material.dart';

import 'directory.dart';
import 'files/audio_file.dart';
import 'files/image_file.dart';
import 'files/text_file.dart';
import 'files/video_file.dart';

class CompositeExample extends StatelessWidget {
  const CompositeExample();

  Widget _buildMediaDirectory() {
    final Directory musicDirectory = Directory('Music');
    musicDirectory.addFile(
      const AudioFile(title: 'Darude - Sandstorm.mp3', size: 2612453),
    );
    musicDirectory.addFile(
      const AudioFile(title: 'Toto - Africa.mp3', size: 3219811),
    );
    musicDirectory.addFile(
      const AudioFile(title: 'Bag Raiders - Shooting Stars.mp3', size: 3811214),
    );

    final Directory moviesDirectory = Directory('Movies');

    moviesDirectory.addFile(
      const VideoFile(title: 'The Matrix.avi', size: 951495532),
    );
    moviesDirectory.addFile(
      const VideoFile(title: 'The Matrix Reloaded.mp4', size: 1251495532),
    );

    final Directory catPicturesDirectory = Directory('Cats');
    catPicturesDirectory.addFile(
      const ImageFile(title: 'Cat 1.jpg', size: 844497),
    );
    catPicturesDirectory.addFile(
      const ImageFile(title: 'Cat 2.jpg', size: 975363),
    );
    catPicturesDirectory.addFile(
      const ImageFile(title: 'Cat 3.png', size: 1975363),
    );

    final Directory picturesDirectory = Directory('Pictures');
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(
      const ImageFile(title: 'Not a cat.png', size: 2971361),
    );

    final Directory mediaDirectory = Directory('Media', isInitiallyExpanded: true);
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(Directory('New Folder'));
    mediaDirectory.addFile(
      const TextFile(title: 'Nothing suspicious there.txt', size: 430791),
    );
    mediaDirectory.addFile(
      const TextFile(title: 'TeamTrees.txt', size: 104),
    );

    return mediaDirectory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: _buildMediaDirectory(),
        ),
      ),
    );
  }
}
