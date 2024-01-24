#!/bin/bash
# vim: ts=2 sts=2 sw=2
# Description: generates clean package list from packages.md, consumable by pacman or aur helpers.

sed '/^#/d;s/+//;s/^[[:space:]]*//' packages.md >/tmp/pkglist

echo "Done: '/tmp/pkglist'"
