#!/bin/bash
env $(cat .env | xargs) mix deps.get
env $(cat .env | xargs) mix firmware && env $(cat .env | xargs) ./upload.sh 192.168.0.15
