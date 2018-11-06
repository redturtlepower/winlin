INSTALLER="none"
MAJOR=5
case "$OSTYPE" in
	darwin*)
      echo "OSX"
      INSTALLER="OSX INSTALLER"
      URL=https://test.com/$MAJOR/$INSTALLER
      echo "Url:"$URL
esac
echo "Installer:"$INSTALLER