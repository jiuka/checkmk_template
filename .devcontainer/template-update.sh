#!/usr/bin/bash

TEMPDIR=$(mktemp -d)

cleanup() {
  echo "Removing $TEMPDIR"
  rm -rf $TEMPDIR
}
trap cleanup EXIT

git -C $TEMPDIR clone https://github.com/jiuka/checkmk_template.git

CMD="rsync --archive --cvs-exclude --no-owner --no-group --no-times --verbose"
if [ -e ".devcontainer/template-sync.conf" ]; then
    CMD="${CMD} --filter='merge .devcontainer/template-sync.conf'"
fi
if [ -e "${TEMPDIR}/checkmk_template/.devcontainer/template-sync-includes.conf" ]; then
    CMD="${CMD} --filter='merge ${TEMPDIR}/checkmk_template/.devcontainer/template-sync-includes.conf'"
fi
CMD="${CMD} --filter='exclude *' ${TEMPDIR}/checkmk_template/ $(pwd)/"
bash -c "$CMD"

echo $CMD