#!/usr/bin/env bash

sh "cat index.html | grep '<p><small>Deployed by Jenkins job: ${BUILD_NUMBER}</small></p>'"