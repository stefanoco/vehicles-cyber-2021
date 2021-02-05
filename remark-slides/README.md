# Remark assets for slides management at Bluewind

Please include this repository as a submodule in your slides project
and enjoy using Markdown for easy preparation of HTML based slides
at Bluewind.

# Starting a new slides set

  - start a new repository for the slides project
  - include this repository as a submodule
  - create template folders using a script
  - modify README.md

```bash
# commands in a bash shell
#
# HERE three items to be configured
#
GITREPO=<new-repo-name>
GITGROUP=<BWGROUP>
REPOCOMMENT="<This is a description of my new project>"
#
# From this point onwards is should be possible
# to type commands without modifications
#
mkdir $GITREPO && cd $_ && touch .keepme
git init && git add . && git commit -m "new"
git submodule add git@git.bwlocal.it:BWTEACH/remark-slides.git
cd remark-slides && script/create-slides.sh "$GITREPO" "$REPOCOMMENT"
cd .. && nano README.md
```

# Pushing the newly created slides set to a repository with CI automation

When starting a new slides set it may also be pushed to a Gitlab repository
with the benefit of CI automation if needed.

  - push to create a repository in the official Bluewind Gitlab server
  - modify how submodule(s) are referenced so that CI can manage them

```bash
# commands in a bash shell
#
# requires that the macros already set in a previous step
# for bash shell are still valid
#
sed -i 's/git@git.bwlocal.it:/..\/..\//g' .gitmodules
git add . && git commit -m "new slides set ready to start"
git push --set-upstream git@git.bwlocal.it:$GITGROUP/$GITREPO.git master
```
  - configure the newly created Bluewind Gitlab server repository for CI
  - now you can start adding slides

# Slides preparation and usage workflow

Please read the enclosed specific manual `remark-README.md.example`.

### Credits

- 2021 Stefano Costa, Bluewind
- https://github.com/gnab/remark/wiki
