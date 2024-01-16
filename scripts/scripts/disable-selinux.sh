#!/usr/bin/env sh

sudo setenforce 0
sestatus | grep "Current mode"
