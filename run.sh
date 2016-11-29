#!/usr/bin/env bash

tensorboard --logdir=/tmp  --port=$PORT1 &
jupyter notebook "$@"
