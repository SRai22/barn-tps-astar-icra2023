#!/bin/bash
source /jackal_ws/devel/setup.bash
cd /jackal_ws/src/barn-tps-astar-icra2023
exec ${@:1}
