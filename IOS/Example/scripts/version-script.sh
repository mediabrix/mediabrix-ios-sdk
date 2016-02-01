plist="${PROJECT_DIR}/${INFOPLIST_FILE}"
builddate=`date`
PWD=$(pwd)

if [ $(svn info ${PWD} 2> /dev/null | grep "^URL:" | cut -d" " -f2 | sed s,${REPO}/,,) ]
then
VERSION=$(svnversion)
else
if [ -d $(git rev-parse --git-dir > /dev/null 2>&1) ]
then
VERSION=$(git describe)
else
VERSION="no version"
fi
fi

#defaults write "$plist" CFBundleVersion "${VERSION}"
defaults write "$plist" BuildDate "${builddate}"
