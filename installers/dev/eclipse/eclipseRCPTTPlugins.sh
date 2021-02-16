#!/bin/bash

version=$1
ECLIPSE_HOME="/opt/rcptt$version.ide/rcptt"

# installs:
#-- Marketplace
#-- MAVEN (m2e)
#-- PATH-TOOLS
#-- AnyEditTools
#-- SubClipse
cd "$ECLIPSE_HOME"
sudo ./rcptt \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository \
http://download.eclipse.org/releases/photon,\
http://cdn.rawgit.com/sandipchitale/pathtools/1.0.64/PathToolsUpdateSite/site.xml,\
https://raw.githubusercontent.com/iloveeclipse/plugins/latest/ \
-installIUs \
org.eclipse.epp.mpc.feature.group,\
org.eclipse.m2e.feature.feature.group,\
PathToolsFeature.feature.group,\
AnyEditTools.feature.group \
-vmargs -Declipse.p2.mirrors=true -Djava.net.preferIPv4Stack=true

#fix permission issue: eclipse not startable es installed plugins are owned by root
ECLIPSE_OWNER=`stat -c %U $ECLIPSE_HOME`
sudo chown -R $ECLIPSE_OWNER:$ECLIPSE_OWNER $ECLIPSE_HOME

