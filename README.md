# sleep guardian
<img src="imgs/icon.jpg" alt="Watch the video">
This application is designed to recognise and record dream words, users can easily review their own own dream words by playing the recording or text transcription.
### app demo
<a href="https://youtu.be/lCCb6TqLrIQ" target="_blank">
  <img src="imgs/屏幕截图 2024-04-23 113537.png" alt="Watch the video">
</a>
### landing page
<img src="imgs/landing1.png" alt="Watch the video">
<img src="imgs/landing2.png" alt="Watch the video">
<img src="imgs/landing3.png" alt="Watch the video">
<img src="imgs/landing4.png" alt="Watch the video">

### plugins used 
cupertino_icons: ^1.0.6<br>
  audio_session: ^0.1.19<br>
 
  path_provider: ^2.1.3<br>
  flutter_silero_vad: the VAD model<br>
  
  url: https://github.com/char5742/flutter_silero_vad.git<br>
  permission_handler: ^11.3.1<br>
  audioplayers: ^6.0.0 player the audio<br>
  hooks_riverpod: ^2.3.6<br>
  workmanager: ^0.5.2<br>
  googleapis_auth: ^1.4.1 google service authcation<br>
  google_speech: ^2.2.0 for speech to text service<br>
  flutter_hooks: ^0.20.5<br>
  newton_particles: ^0.1.7 for background animiation <br>
  slide_digital_clock: ^1.0.3 digital clock<br>
  provider: ^6.1.2 find the file path<br>
  slide_countdown: ^1.6.1 for time counting<br>


## A Section That Tells Developers How To Install The App

# Installation Guide

This guide will help you set up and run a Flutter application in Visual Studio Code.

## Prerequisites

Before you begin, ensure you have the following software installed:

- **Git**: For cloning the repository.
- **Flutter SDK**: Essential for Flutter development.
- **Visual Studio Code**: The recommended editor.
- **VS Code Flutter Extension**: To support Flutter development in VS Code.

You can follow these links for installation instructions:
- Git: https://git-scm.com/downloads
- Flutter SDK: https://flutter.dev/docs/get-started/install
- Visual Studio Code: https://code.visualstudio.com/download

## Cloning the Repository

First, open your command line tool and execute the following commands to clone the GitHub repository:

```bash
git clone https://github.com/liangleiliu-lab/casa0015-mobile-assessment.git
cd casa0015-mobile-assessment
```
After cloning the repository, you need to install the necessary dependencies for the project. In the project's root directory, run the following command:
```
flutter pub get

```
you need create your own google speech to text serivce key, find detail in: -https://cloud.google.com/speech-to-text<br>
<br>
After get your crditential json file, please put it in `assets` floder.<br>
<br>
Ensure that your device or emulator is connected. Then, open the project folder in Visual Studio Code, select your device, and click the run button or execute the following command in the terminal:
```
flutter run

```
##  Contact Details

Having Contact Details is also good as it shows people how to get in contact with you if they'd like to contribute to the app. 
