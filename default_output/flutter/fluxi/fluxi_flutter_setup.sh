#!/bin/bash
flutter create fluxi_flutter
cd fluxi_flutter
flutter pub add phoenix_socket
flutter pub add provider
flutter pub add sqflite
flutter pub get
cd ..
touch fluxiconf.fluxi
echo "flutter_project_location: $(pwd)" >> fluxiconf.fluxi
git init
git add .
git commit -m "Hello from fluxi"
echo "$(tput setaf 2)Fluxi intialized flutter project for fluxi!$(tput sgr0)"
