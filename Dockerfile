# Ubuntu 
FROM ubuntu
# update and install ubuntu packages
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 git
# Adding wget and bzip2
RUN apt-get install -y wget bzip2
# Anaconda installing
RUN wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
    bash Anaconda3-2019.10-Linux-x86_64.sh -b && \
    rm Anaconda3-2019.10-Linux-x86_64.sh
# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH
# install package to access teradata
RUN pip install git+https://github.roche.com/MDH-Tools/PythonTeradata.git@master
# install code-server and python extension
RUN wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz -O code_server.tar.gz && \
    tar xvzf code_server.tar.gz && \
    cd code-server2.1698-vsc1.41.1-linux-x86_64 && \
    wget https://github.com/microsoft/vscode-python/releases/download/2020.2.63072/ms-python-release.vsix && \
    ./code-server --install-extension ms-python-release.vsix
# run on port 8080, no auth, we could also set the PASSWORD env variable with the password to use (and removing --auth none)
EXPOSE 8080
CMD ["code-server2.1698-vsc1.41.1-linux-x86_64/code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
