#!/bin/sh
VERSION=$(<VERSION)
docker build . -t dkaber/codestream-ci-packer:latest -t dkaber/codestream-ci-packer:v$VERSION --build-arg VERSION=$VERSION
docker login --username $DOCKERUSER --password $DOCKERPASS
docker push dkaber/codestream-ci-packer:latest
docker push dkaber/codestream-ci-packer:v$VERSION