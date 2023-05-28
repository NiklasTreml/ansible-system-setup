FROM ubuntu:latest

ARG USERNAME=cocker
# Install python and pip3
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update

RUN apt install python3.10 -y
RUN apt install curl -y
RUN apt install sudo -y
RUN useradd ${USERNAME} -m
RUN usermod -aG sudo ${USERNAME}
RUN sudo passwd -dl root
RUN sudo passwd -dl ${USERNAME}
RUN echo ${USERNAME} ALL=NOPASSWD: ALL >> /etc/sudoers

WORKDIR /home/${USERNAME}
USER ${USERNAME}

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py --user
RUN python3 -m pip install --user ansible
RUN echo export PATH=$PATH:/home/${USERNAME}/.local/bin >> /home/${USERNAME}/.bashrc
SHELL ["/bin/bash", "-c"]
COPY . .

