#!/bin/bash
singularity exec -i --nv -n --network=none -p -B `pwd`:/jackal_ws/src/barn-tps-astar-icra2023 ${1} /bin/bash /jackal_ws/src/barn-tps-astar-icra2023/entrypoint.sh ${@:2}
