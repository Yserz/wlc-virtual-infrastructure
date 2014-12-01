#!/bin/bash
git subtree pull --squash --prefix wlc-boxes wlc-boxes master
git subtree pull --squash --prefix virtual-chef-server/chef-repo wlc-chef-repo master