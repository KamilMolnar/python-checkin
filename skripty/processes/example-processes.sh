#!/usr/bin/env bash

echo "processes"

echo "move process to background"
sleep 10 &

echo "pid of last backgroun process"
sleep 5 &
echo "$!"
ps -ef | grep 'sleep 5' | grep -v 'grep'



echo "pid of running script"

ps -ef | grep "$0" | grep -v 'grep'
echo "$$"


echo "move process to background and save pid"
sleep 10 &
pid="$!"


echo "check background jobs"
jobs

echo "wait for background jobs"
#wait <pid>
wait "$pid" && {
	echo "sleep job with pid $pid finished"

}
