echo "The qt installation has not been found. Cloning repo 'qt-installer' and installing Qt..."
rm -rf qt-installer
git clone "https://github.com/redturtlepower/qt-installer.git" && cd qt-installer && chmod +x qt-installer.sh
bash qt-installer.sh --list-packages --filedir="/var/installers/" --version=5.12.8
username=$(cat /var/installers/qt-login-username.txt)
password=$(cat /var/installers/qt-login-password.txt)
bash qt-installer.sh --filedir="/var/installers/" --version=5.12.8 --username=$username --password=$password --cleanup
