#!/bin/sh

git rm -f ./scripts/TESTING
git commit -m "Switching to production branch"
git push upstream
