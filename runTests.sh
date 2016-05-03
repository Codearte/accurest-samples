#!/bin/bash

set -o errexit

LOCAL_MAVEN_REPO=${LOCAL_MAVEN_REPO-~/.m2}
ROOT=`pwd`

echo -e "Clearing saved stubs"
rm -rf $LOCAL_MAVEN_REPO/repository/io/codearte/accurest/testprojects/

echo -e "\n\nRunning tests for Gradle\n\n"
echo -e "Building server"
cd http-server
./gradlew clean build publishToMavenLocal
cd $ROOT
echo -e "\n\nBuilding client"
cd http-client
./gradlew clean build
cd $ROOT
