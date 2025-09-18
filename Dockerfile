FROM nvidia/cuda:13.0.1-cudnn-runtime-ubuntu24.04

ENV USERNAME=steamuser \
    PASSWORD=password \
    USER_UID=99 \
    USER_GID=100 \
    RESOLUTION_HEIGHT=1080 \
    RESOLUTION_WIDTH=1920 \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all

ENV HOME=/home/$USERNAME \
    RESOLUTION=${RESOLUTION_WIDTH}x${RESOLUTION_HEIGHT}

ARG USER=root \
    DEBIAN_FRONTEND=noninteractive

RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    xfonts-base \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p $HOME/.vnc && echo $PASSWORD | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd

RUN chown -R $USERNAME:users $HOME

RUN touch /root/.Xauthority \
    && touch $HOME/.Xauthority

WORKDIR $HOME/app

COPY app .

EXPOSE 5901

RUN chmod +x ./start.sh
ENTRYPOINT ["./start.sh"]
