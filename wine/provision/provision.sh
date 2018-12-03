echo "On wine the qt provisioner does not use the official qt installer. This script only copy the required files, which are required for compiling with MSVC, from the mounted volume to the wine dir."
echo "Copying files to ~/.wine/drive_c/"
mkdir -p /home/jenkins/.wine/drive_c

cp -R /var/installers/qt511-msvc/buildenv/. /home/jenkins/.wine/drive_c/buildenv/
# Give user jenkins permissions:
chown -R jenkins:jenkins /home/jenkins/.wine