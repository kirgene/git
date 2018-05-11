FROM alpine

RUN apk --update add git git-lfs openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN mkdir -p /root/.ssh/
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN echo -e "\n\n\n" && \
	seq -s= 100|tr -d '[:digit:]' && \
	cat /root/.ssh/id_rsa.pub && \
	seq -s= 100|tr -d '[:digit:]' && \
	echo -e "\n\n\n"

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]
