#/!bin/bash

purge-old-kernels
docker system prune -a --volumes -f

#logs
journalctl --disk-usage
journalctl --vacuum-size=200M

# designer downloads
rm -rf /tmp/Axon*

/home/rew/.m2/cleanOsgi.sh
