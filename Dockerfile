FROM debian:stretch
RUN apt-get update
RUN apt-get install -y sudo wget apt git python-dev python-pip build-essential mono-complete openjdk-8-jdk ruby php ghc clang libicu-dev nano #nano debconf-utils mysql-client libmysqlclient-dev gnupg wget git gcc g++ make python-dev libxml2-dev libxslt1-dev zlib1g-dev gettext curl wget openssl ruby ruby-dev gem 

RUN pip install --upgrade pip

RUN pip install setuptools
RUN pip install cython


#RUN wget https://swift.org/builds/swift-4.0.2-release/ubuntu1610/swift-4.0.2-RELEASE/swift-4.0.2-RELEASE-ubuntu16.10.tar.gz -o /dev/null -O - | tar xzf - -C /tmp
#RUN mv /tmp/swift* /opt/swift4

#RUN chown nobody /opt/swift4/usr/lib/swift/CoreFoundation/module.modulemap

RUN git clone https://github.com/Maitre-Hiboux/dmoj-judge-docker

WORKDIR /
RUN chmod 755 /dmoj-judge-docker/*
#RUN /dmoj-judge-docker/build-v8dmoj-part1.sh
#RUN /dmoj-judge-docker/build-v8dmoj-part2.sh

WORKDIR /vagrant

#RUN cp -r /vagrant/v8dmoj_bin /opt

RUN git clone https://github.com/minkov/judge /vagrant/judge
WORKDIR /vagrant/judge

RUN pip install -r requirements.txt

RUN python setup.py develop

#RUN git clone https://github.com/cuklev/dsa-miniexam-tasks-dmoj.git /problems
RUN cp /dmoj-judge-docker/systemd_files/* /etc/systemd/system/
RUN cp -R /dmoj-judge-docker/aplusb /problems/
#RUN /dmoj-judge-docker/start.sh

ENTRYPOINT ["/dmoj-judge-docker/docker-entrypoint.sh"]
