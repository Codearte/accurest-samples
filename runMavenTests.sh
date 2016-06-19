#!/bin/bash

set -o errexit

LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO-~/.m2}
ACCUREST_VERSION=${ACCUREST_VERSION:-1.0.0.BUILD-SNAPSHOT}
ROOT=`pwd`

cat <<EOF
Running tests with the following parameters
LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO}
ACCUREST_VERSION=${ACCUREST_VERSION}
EOF

echo -e "\n\nClearing saved stubs"
rm -rf $LOCAL_MAVEN_REPO/repository/org/springframework/cloud/contract/testprojects/

echo -e "\n\nRunning tests for Maven\n\n"
echo -e "Building server (uses Accurest Maven Plugin)"
cd http-server
./mvnw clean install -Daccurest.version=${ACCUREST_VERSION}
cd $ROOT
echo -e "\n\nBuilding client (uses Accurest Stub Runner)"
cd http-client
./mvnw clean package -Daccurest.version=${ACCUREST_VERSION}
cd $ROOT
