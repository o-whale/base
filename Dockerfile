FROM ubuntu:18.04
LABEL maintainer="Bluewhale <blue@owhale.com>"

# refresh packages
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    git \
    software-properties-common \
    net-tools \
    iproute2 \
    locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# zsh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zsh
RUN chsh -s /bin/zsh
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git "/root/.zprezto"
COPY zpreztorc /root/.zpreztorc
COPY zshrc /root/.zshrc

# vim
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim
RUN mkdir -p "/root/.vim"
RUN mkdir -p "/root/.vim/bundle"
RUN git clone https://github.com/VundleVim/Vundle.vim.git "/root/.vim/bundle/Vundle.vim"
COPY vimrc /root/.vimrc
RUN vim +PluginInstall +qall

# tmux
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tmux
COPY tmux.conf /root/.tmux.conf

WORKDIR /root
CMD /bin/zsh
