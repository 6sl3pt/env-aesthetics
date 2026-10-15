#!/bin/bash

rand() {
  case "$1" in
  time)
    date -d "@$((RANDOM % 86400))" '+%H:%M:%S'
    ;;

  date)
    start=$(date -d '2020-01-01 00:00:00' +%s)
    now=$(date +%s)
    random=$(od -An -N8 -tu8 /dev/urandom)
    timestamp=$((start + random % (now - start + 1)))
    date -d "@$timestamp" '+%Y-%m-%d'
    ;;

  datetime)
    start=$(date -d '2020-01-01 00:00:00' +%s)
    now=$(date +%s)
    random=$(od -An -N8 -tu8 /dev/urandom)
    timestamp=$((start + random % (now - start + 1)))
    date -d "@$timestamp" '+%Y-%m-%d %H:%M:%S'
    ;;

  *)
    echo "Usage:"
    echo "  rand time"
    echo "  rand date"
    echo "  rand datetime"
    ;;
  esac
}
