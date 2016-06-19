#!/bin/bash

set -o errexit

LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO-~/.m2}
VERIFIER_VERSION=${VERIFIER_VERSION:-1.0.0.BUILD-SNAPSHOT}
ROOT=`pwd`

cat <<EOF
Running tests with the following parameters
LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO}
VERIFIER_VERSION=${VERIFIER_VERSION}
EOF

echo -e "\n\nClearing saved stubs"
rm -rf $LOCAL_MAVEN_REPO/repository/org/springframework/cloud/contract/testprojects/

echo -e "\n\nRunning tests for Maven\n\n"
echo -e "Building server (uses Spring Cloud Contract Verifier Maven Plugin)"
cd http-server
./mvnw clean install -Daccurest.version=${VERIFIER_VERSION}
cd $ROOT
echo -e "\n\nBuilding client (uses Spring Cloud Contract Stub Runner)"
cd http-client
./mvnw clean package -Daccurest.version=${VERIFIER_VERSION}
cd $ROOT
