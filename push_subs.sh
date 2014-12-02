#!/bin/bash
git subtree push --squash --prefix wlc-boxes wlc-boxes master
git subtree push --squash --prefix virtual-chef-server/chef-repo wlc-chef-repo master
git push