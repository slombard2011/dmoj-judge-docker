#!/bin/bash

for cmd in enable start; do
    for unit in dmoj-judge@Local.service dmoj-sync-problems.timer; do
		systemctl $cmd $unit
	done
done
