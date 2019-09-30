FROM jenkins/jenkins:centos
USER root
RUN yum makecache && \
    yum -y -q upgrade && \
    yum install -y make bzip2 wget  && \
    echo "#### python env install ####" && \
    yum install -y python36 && \
    yum install -y python-pip && \
    pip install --upgrade pip && \
    pip install yq && \
    echo "#### docker client install ####" && \
    wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-19.03.1.tgz && \
    gunzip -c docker.tgz | tar xvf - && \
    mv docker/docker /usr/bin/docker && \
    chmod +x /usr/bin/docker && \
    rm -rf ./docker ./docker.tgz && \
    echo "#### update system & application timezone ####" && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" >> /etc/timezone && \
    yum clean all
