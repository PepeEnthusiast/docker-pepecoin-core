#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for pepecoind"

  set -- pepecoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "pepecoind" ]; then
  mkdir -p "$PEPECOIN_DATA"
  chmod 700 "$PEPECOIN_DATA"
  chown -R pepecoin "$PEPECOIN_DATA"

  echo "$0: setting data directory to $PEPECOIN_DATA"

  set -- "$@" -datadir="$PEPECOIN_DATA"
fi

if [ "$1" = "pepecoind" ] || [ "$1" = "pepecoin-cli" ] || [ "$1" = "pepecoin-tx" ]; then
  echo
  exec gosu pepecoin "$@"
fi

echo
exec "$@"
