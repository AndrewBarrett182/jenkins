#!/usr/bin/env bash

cat index.html | grep "<p><small>Deployed by Jenkins job: ${1}</small></p>"