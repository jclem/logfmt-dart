set -e

DART_DIST=dartsdk-linux-x64-release.zip

echo Fetching dart sdk
curl http://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/$DART_DIST > $DART_DIST

unzip $DART_DIST > /dev/null
rm $DART_DIST

export DART_SDK="$PWD/dart-sdk"
export PATH="$DART_SDK/bin:$PATH"

echo Pub install
pub install

dart test/test.dart
