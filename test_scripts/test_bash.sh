#!/usr/bin/env bash

BUILD_TARGETS=$(bazel query //cyber/...)

JOB_ARG="--jobs=$(nproc) --ram_utilization_factor 80"
