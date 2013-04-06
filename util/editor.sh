#!/usr/bin/env bash

case "$1" in
  knife-edit* )
    /usr/bin/env vim "$1"
    ;;
  * )
    /usr/bin/env vim "$1"
    ;;
esac
