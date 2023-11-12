FROM --platform=linux/amd64 kasmweb/core-ubuntu-focal:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN apt-get update && apt-get install -y apt-utils

RUN  wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb \
    && apt-get update \
    && apt-get install -y ./dbeaver-ce_latest_amd64.deb \
    && rm dbeaver-ce_latest_amd64.deb \
    && apt-get clean
######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000