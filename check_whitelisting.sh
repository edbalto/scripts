#!/bin/bash

echo "Healthcheck of whitelist to *.baltocloud.com"
status_code=$(curl --write-out %{http_code} $1 https://processing-nginx.baltocloud.com/afs/healthcheck)
if [ "$status_code" != ok200 ] ; then
  echo
  echo "************ ERROR Connecting to *.baltocloud.com!! (" $status_code ")"
  echo
fi

echo "Healthcheck of whitelist to Launch Darkly"
status_code=$(curl -s -o /dev/null --write-out %{http_code} $1 https://app.launchdarkly.com/api/v2/public-ip-list)
if [ "$status_code" != 200 ] ; then
  echo
  echo "************ ERROR Connecting to *.launchdarkly.com!! (" $status_code ")"
  echo
fi

echo "Healthcheck of whitelist to Pendo"
status_code=$(curl -s -o /dev/null --write-out %{http_code} $1 https://app.pendo.io/api/v1/report)
if [ "$status_code" != 403 ] ; then
  echo
  echo "************ ERROR Connecting to *.pendo.io!! (" $status_code ")"
  echo
fi
