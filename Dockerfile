FROM photon:latest
ARG VERSION
LABEL maintainer="Kaber"
LABEL version="$VERSION"

# Update packages and install new ones
RUN tdnf install -y curl unzip git wget tar bindutils coreutils xorriso jq mkpasswd iptables && \
    tdnf autoremove -y && \
    tdnf clean all

# Install Packer
ADD https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip ./
RUN unzip packer_${VERSION}_linux_amd64.zip -d /bin && \
    rm -f packer_${VERSION}_linux_amd64.zip

#Change Firewall Rules for Photon OS
RUN iptables -A INPUT -p tcp --dport 443 -j ACCEPT && \
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT && \
    iptables -A INPUT -p tcp --dport 8064 -j ACCEPT

# Complete
ADD VERSION .