FROM nvidia/cuda:13.0.1-cudnn-runtime-ubuntu24.04

ARG USERNAME=steam
#1000
ARG USER_UID=99
#$USER_UID
ARG USER_GID=100
ARG HOSTNAME=Steam

#RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

ENV USER=root

RUN apt update && apt install -y sudo xfce4 xfce4-goodies tightvncserver dbus-x11 xfonts-base vim && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /root/.vnc && echo "password" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd
RUN mkdir -p /home/$USERNAME/.vnc && echo "password" | vncpasswd -f > /home/$USERNAME/.vnc/passwd && chmod 600 /home/$USERNAME/.vnc/passwd
RUN chown -R $USERNAME:users /home/$USERNAME
RUN touch /root/.Xauthority
RUN touch /home/$USERNAME/.Xauthority

ENV RESOLUTION=1920x1080

EXPOSE 5901

WORKDIR /app

RUN chown -R $USERNAME:users /app

COPY /app/start-vnc.sh start-vnc.sh

RUN chmod +x start-vnc.sh
RUN ls -a /app

USER $USERNAME

ENTRYPOINT ["/app/start-vnc.sh"]