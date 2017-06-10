FROM openjdk:8-jre-alpine

ENV KOTLIN_HOME /opt/kotlinc
ENV KOTLIN_VERSION 1.1.2-2

RUN set -o errexit -o nounset \
    && echo "Downloading Kotlin" \
    && apk --no-cache add bash ca-certificates wget \
    && wget --no-verbose --output-document=/tmp/kotlin-compiler.zip "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" \
    && mkdir -p /opt \
    && unzip -d /opt /tmp/kotlin-compiler.zip \
    && rm /tmp/kotlin-compiler.zip

RUN ln -s "${KOTLIN_HOME}/bin/kotlin" /usr/bin/kotlin \
    && ln -s "${KOTLIN_HOME}/bin/kotlinc" /usr/bin/kotlinc \
    && ln -s "${KOTLIN_HOME}/bin/kotlinc-js" /usr/bin/kotlinc-js \
    && ln -s "${KOTLIN_HOME}/bin/kotlinc-jvm" /usr/bin/kotlinc-jvm

WORKDIR /opt/kotlinc
CMD ["kotlinc"]
