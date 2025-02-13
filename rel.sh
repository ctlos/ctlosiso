#!/bin/bash

# if [ "$1" == "" ]; then
#     echo "Missing parameter! TAG_NAME";
#     exit 1;
# fi

TAG_NAME=v2.4.7

git tag ${TAG_NAME}
git push --tags

### release sf
# REPO_SF=ctlos@web.sourceforge.net:/home/pfs/project/ctlos
# SCRIPT_PATH=$(realpath -- ${0%/*})
# ISO_PATH=$SCRIPT_PATH/out

# cp -r $SCRIPT_PATH/rel.md ${ISO_PATH}/README.md
# sed -i "s/TAG_NAME/$TAG_NAME/" ${ISO_PATH}/README.md

# rsync -cauvCLP --delete-excluded --delete "${ISO_PATH}/" "${REPO_SF}/${TAG_NAME}/"
