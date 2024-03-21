#!/bin/bash

repo=$HOME/.m2/repository

# osgi
rm -rfv ${repo}/.cache/tycho
rm -rfv ${repo}/p2

# ivy-engines
rm -rfv ${repo}/.cache/ivy
rm -rfv ${repo}/.cache/ivy-dev

# large ivy-artifacts
ivyPrefix=${repo}/ch/ivyteam/ivy
rm -rfv "${ivyPrefix}/addons"
rm -rfv "${ivyPrefix}/ch.ivyteam.ivy.designer.product"
rm -rfv "${ivyPrefix}/ch.ivyteam.ivy.server.product"
rm -rfv "${ivyPrefix}/ch.ivyteam.ivy.thirdparty.lib.p2"
rm -rfv "${ivyPrefix}/project/portal"
