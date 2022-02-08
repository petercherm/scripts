#!/bin/zsh

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CURRENT_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Make sure we don't make a backup branch repeatedly
if [[ $CURRENT_BRANCH_NAME == backup* ]]; then
	>&2 echo "${YELLOW}Branch '"$CURRENT_BRANCH_NAME"' is already a backup${NC}"
	exit 1
fi

BACKUP_BRANCH_NAME="backup/$(date +%Y-%m-%d__%H-%M-%S)/$CURRENT_BRANCH_NAME"

git branch $BACKUP_BRANCH_NAME

echo "${YELLOW}Current branch has been backed up as: $BACKUP_BRANCH_NAME${NC}"
echo "${YELLOW}Rebasing onto master...${NC}"

git pull origin master --rebase
