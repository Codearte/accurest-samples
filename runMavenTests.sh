#!/bin/bash

set -o errexit

LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO-~/.m2}
ACCUREST_VERSION=${ACCUREST_VERSION:-1.1.0-M4}
ROOT=`pwd`

echo -e "Clearing saved stubs"
rm -rf $LOCAL_MAVEN_REPO/repository/io/codearte/accurest/testprojects/

echo -e "\n\nRunning tests for Maven\n\n"
echo -e "Building server (uses Accurest Maven Plugin)"
cd http-server
./mvnw clean install -Daccurest.version=${ACCUREST_VERSION}
cd $ROOT
echo -e "\n\nBuilding client (uses Accurest Stub Runner)"
cd http-client
./mvnw clean package -Daccurest.version=${ACCUREST_VERSION}
cd $ROOT
