FROM debian:bullseye-20210511-slim as build
RUN apt update && apt install -y wget zip unzip git tar
RUN mkdir /android
WORKDIR /android
RUN wget -c "https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip"
RUN wget -c "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10%2B9_openj9-0.24.0/OpenJDK11U-jdk_x64_linux_openj9_11.0.10_9_openj9-0.24.0.tar.gz"
RUN unzip commandlinetools-linux-7302050_latest.zip
RUN tar -xvf OpenJDK11U-jdk_x64_linux_openj9_11.0.10_9_openj9-0.24.0.tar.gz
RUN rm commandlinetools-linux-7302050_latest.zip OpenJDK11U-jdk_x64_linux_openj9_11.0.10_9_openj9-0.24.0.tar.gz
ENV ANDROID_HOME=/android JAVA_HOME=/android/jdk-11.0.10+9 ANDROID_SDK_ROOT=/android
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install "cmdline-tools;latest"

FROM debian:bullseye-20210511-slim
COPY --from=build /android /android
COPY --from=build /usr/bin/zip /usr/local/bin/zip
COPY --from=build /usr/bin/unzip /usr/local/bin/unzip
COPY --from=build /usr/bin/git /usr/local/bin/git
ENV ANDROID_HOME=/android JAVA_HOME=/android/jdk-11.0.10+9 ANDROID_SDK_ROOT=/android
ENTRYPOINT ["/bin/bash"]