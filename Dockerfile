FROM debian:stretch
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y sudo wget curl apt net-tools git libseccomp-dev python-dev python-pip python3 build-essential mono-complete openjdk-8-jdk ruby php ghc clang libicu-dev nano ninja-build debconf-utils gnupg gcc g++ make libxml2-dev libxslt1-dev zlib1g-dev gettext openssl ruby ruby-dev gem scala

RUN pip install --upgrade pip

RUN pip install setuptools
RUN pip install cython


RUN wget https://swift.org/builds/swift-4.0.2-release/ubuntu1610/swift-4.0.2-RELEASE/swift-4.0.2-RELEASE-ubuntu16.10.tar.gz -o /dev/null -O - | tar xzf - -C /tmp
RUN mv /tmp/swift* /usr/bin/swift4

RUN chown nobody /usr/bin/swift4/usr/lib/swift/CoreFoundation/module.modulemap
RUN mkdir -p /dmoj-judge-docker/aplusb
RUN mkdir /dmoj-judge-docker/systemd_files
COPY * /dmoj-judge-docker/
COPY aplusb/* /dmoj-judge-docker/aplusb/
COPY systemd_files/* /dmoj-judge-docker/systemd_files/

WORKDIR /
RUN mkdir /dmoj
RUN chmod 755 /dmoj-judge-docker/*

RUN cp /dmoj-judge-docker/systemd_files/v8dmoj.list /etc/apt/sources.list.d/
RUN chmod +rw /etc/apt/sources.list.d/v8dmoj.list
RUN curl https://dmoj.ca/dmoj-apt.key | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y v8dmoj

WORKDIR /dmoj

#RUN git clone https://github.com/minkov/judge /dmoj/judge
RUN git clone https://github.com/DMOJ/judge
WORKDIR /dmoj/judge

RUN pip install -r requirements.txt

RUN python setup.py develop

RUN cp /dmoj-judge-docker/systemd_files/* /etc/systemd/system/
RUN mkdir -p /problems/aplusb
RUN cp /dmoj-judge-docker/aplusb/* /problems/aplusb/

ENTRYPOINT ["/dmoj-judge-docker/docker-entrypoint.sh"]
CMD ["","the_judge","0123456789"]
