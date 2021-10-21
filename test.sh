#!/usr/bin/env bash
cd
cat index.html | grep "<p><small>Deployed by Jenkins job: ${BUILD_NUMBER}</small></p>"