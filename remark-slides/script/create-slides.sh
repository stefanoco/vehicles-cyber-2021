#!/bin/bash

DIRECTORY_NAME=project_root
TAG_PROJECTNAME="{{PROJECT_NAME}}"
TAG_PROJECTDESCR="{{PROJECT_DESCRIPTION}}"

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <PROJECT_NAME> \"<PROJECT_DESCRIPTION>\"" >&2
  exit 1
fi

# get dir and parent dir
# as seen on:
#  https://stackoverflow.com/questions/8426058/getting-the-parent-of-a-directory-in-bash
#  https://stackoverflow.com/questions/3294072/bash-get-last-dirname-filename-in-a-file-path-argument
thisdir=$(basename `eval "cd .;pwd;cd - > /dev/null"`)
projectdir=$(basename $(dirname `eval "cd .;pwd;cd - > /dev/null"`))

if [ ! "$thisdir" == "remark-slides" ]; then
  echo "You're not in the right folder (remark-slides) it seems. Please check documentation." >&2
  exit 1
fi

if [ ! "$projectdir" == "$1" ]; then
  echo "Project name ($1) different from parent folder name it seems. Please check documentation." >&2
  exit 1
fi

if [ ! -d "${DIRECTORY_NAME}" ]; then
  echo "Can't find the template folder ${DIRECTORY_NAME} it seems. Please check documentation." >&2
  exit 1
fi

project_name=$(printf "%q" $1)
project_descr=$2

echo -e "Replace ${TAG_PROJECTNAME} in project template files with ${project_name}...\n\n"
grep -rl ${TAG_PROJECTNAME} ${DIRECTORY_NAME}/ | xargs sed -i "s/${TAG_PROJECTNAME}/${project_name}/g"

echo -e "Replace ${TAG_PROJECTDESCR} in project template files with ${project_descr}...\n\n"
grep -rl ${TAG_PROJECTDESCR} ${DIRECTORY_NAME}/ | xargs sed -i "s/${TAG_PROJECTDESCR}/${project_descr}/g"

echo -e "Copy template folder structure ${DIRECTORY_NAME} to the root of new project...\n\n"

for i in $(find ${DIRECTORY_NAME} | sed s:"${DIRECTORY_NAME}/":: | sed s:"${DIRECTORY_NAME}"::)
do
	if [ -d "${DIRECTORY_NAME}/${i}" ]; then
		if [ ! -d "../${i}" ]; then
			echo -e "mkdir ../${i}"
			mkdir ../${i}
		else
			echo -e "directory ../${i} already present!"
		fi
	fi

	if [ -f "${DIRECTORY_NAME}/${i}" ]; then
		if [ ! -f ../${i} ]; then
			echo -e "cp ${DIRECTORY_NAME}/${i} ../${i}"
			cp ${DIRECTORY_NAME}/${i} ../${i}
		else
			echo -e "file ../${i} already present!"
		fi
	fi
done

#undo files modifications
echo -e "\nUndo template files modifications...\n\n"
git checkout -- .

echo -e "\n...done.\n"

exit 0
