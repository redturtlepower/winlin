echo "On wine the qt provisioner does not use the official qt installer. We only copy the required files, which are required for compiling with MSVC, from the mounted volume to the wine dir."
echo "Copying files to ~/.wine/drive_c/"
cp -R /var/installers/windows/qt511-msvc/buildenv/. ~/.wine/drive_c/buildenv/