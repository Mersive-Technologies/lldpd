FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y autoconf \
                       automake \
                       libc6 \
                       libncurses5 \
                       libstdc++6 \
                       libbz2-1.0 \
                       libtool \
                       openjdk-8-jdk \
                       curl \
                       git \
                       npm \
                       m4 \
                       pkg-config \
                       usbutils \
                       unzip

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN useradd -m devel
USER devel

ENV ANDROID_SDK_ROOT=/home/devel/.android/sdk
ENV ANDROID_HOME="${ANDROID_SDK_ROOT}"
ENV PATH="${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${PATH}"

RUN mkdir -p ${ANDROID_SDK_ROOT}
ADD --chown=devel:devel https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip ${ANDROID_SDK_ROOT}/cmdline-tools.zip

ENV NDK_VERSION="21.3.6528147"

RUN cd ${ANDROID_SDK_ROOT} \
 && unzip cmdline-tools.zip \
 && rm -f cmdline-tools.zip \
 && mkdir latest \
 && mv cmdline-tools/* latest \
 && mv latest cmdline-tools \
 && yes | sdkmanager --licenses \
 && sdkmanager platform-tools \
               "ndk;${NDK_VERSION}" \
               "platforms;android-25"

ENV TOOLCHAIN="${ANDROID_SDK_ROOT}/ndk/${NDK_VERSION}/toolchains/llvm/prebuilt/linux-x86_64"
ENV TARGET="aarch64-linux-android"
ENV API=24

ENV AR=$TOOLCHAIN/bin/llvm-ar
ENV CC=$TOOLCHAIN/bin/$TARGET$API-clang
ENV CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
ENV LD=$TOOLCHAIN/bin/ld.lld
ENV RANLIB=$TOOLCHAIN/bin/llvm-ranlib
ENV STRIP=$TOOLCHAIN/bin/llvm-strip
ENV AS=$CC

VOLUME ["/home/devel/lldpd"]
CMD ["/bin/bash"]