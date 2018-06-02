#!/bin/bash

if (( ${#} != 1 )); then
  echo "${0} <cc>" 1>&2
  exit 1
fi

cci="${1}"

docker pull figroc/psocks

run="bash $(dirname ${0})/run.sh"
${run} chenp  50050 ${cci}
${run} victor 10050 ${cci}
${run} baiyj  10150 ${cci}
${run} gmw    10250 ${cci}
${run} liud   10350 ${cci}
${run} wangy  10450 ${cci}
