#!/bin/bash

set -o errexit

LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO-~/.m2}
ROOT=`pwd`

echo -e "Clearing saved stubs"
rm -rf $LOCAL_MAVEN_REPO/repository/io/codearte/accurest/testprojects/

echo -e "\n\nRunning tests for Gradle\n\n"
echo -e "Building server"
cd http-server
./mvnw clean install
cd $ROOT
echo -e "\n\nBuilding client"
cd http-client
./mvnw clean package
cd $ROOT
