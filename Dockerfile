FROM nvidia/cuda:13.0.1-cudnn-runtime-ubuntu24.04

ARG USERNAME=steamuser
ARG USER_UID=99
ARG USER_GID=100

RUN useradd --gid $USER_GID -m $USERNAME

ENV USER=root

RUN apt update && apt install -y sudo xfce4 xfce4-goodies tightvncserver dbus-x11 xfonts-base vim && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /root/.vnc && echo "password" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

RUN mkdir -p /home/$USERNAME/.vnc && echo "password" | vncpasswd -f > /home/$USERNAME/.vnc/passwd && chmod 600 /home/$USERNAME/.vnc/passwd

RUN chown -R $USERNAME:users /home/$USERNAME

RUN touch /root/.Xauthority

RUN touch /home/$USERNAME/.Xauthority

ENV RESOLUTION=1920x1080

COPY overlay /

EXPOSE 5901

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]