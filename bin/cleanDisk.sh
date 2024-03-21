#/!bin/bash

purge-old-kernels
docker system prune -a --volumes -f

#logs
journalctl --disk-usage
sudo journalctl --vacuum-size=200M

# designer downloads
rm -rfv /tmp/Axon*

DIR="$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )"
${DIR}/cleanM2Repo.sh

