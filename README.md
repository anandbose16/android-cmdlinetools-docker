# Android SDK Command-line tools image
This container image contains a bare minimal of Android SDK command-line tools, yet it is capable of building Android projects.

## Usage

Pull the image from docker hub

```bash
docker pull anandbose16/android-cmdlinetools:latest
```
Run the container with your project directory as a volume.

```bash
docker run -it -v /path/to/project:/project anandbose16/android-cmdlinetools:latest
```
Now, build your project.
```bash
cd /project
./gradlew clean assembleDebug
```
Done!
## Included binaries
* zip
* unzip
* git
 
## Disclaimer
The Android SDK is a licensed software from Google. By using this container image, you agree to the terms and conditions of Android SDK.
