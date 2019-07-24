FROM openjdk:11

ENV VSP_VERSION 2.0.0
ENV VSP_DOWNLOAD_PATH /tmp/verify-service-provider.zip
ENV VSP_CHECKSUM 9c4e10fb28de1a8422824b8f5900ca7c763025e1ead81a27d8dc67d7fefa7717
ENV VSP_UNZIP_PATH /tmp/verify-service-provider
ENV VSP_HOME /vsp

ADD https://github.com/alphagov/verify-service-provider/releases/download/${VSP_VERSION}/verify-service-provider-${VSP_VERSION}.zip ${VSP_DOWNLOAD_PATH}
RUN [ "$(sha256sum ${VSP_DOWNLOAD_PATH})" = "${VSP_CHECKSUM}  ${VSP_DOWNLOAD_PATH}" ]

RUN unzip ${VSP_DOWNLOAD_PATH} -d ${VSP_UNZIP_PATH}
RUN mv ${VSP_UNZIP_PATH}/verify-service-provider-${VSP_VERSION} ${VSP_HOME}
RUN rm ${VSP_DOWNLOAD_PATH}
RUN rm -r ${VSP_UNZIP_PATH}

WORKDIR ${VSP_HOME}

EXPOSE 50400

CMD [ "bin/verify-service-provider", "server", "verify-service-provider.yml" ]
