#!/bin/bash

# installs:
#-- Marketplace
#-- MAVEN (m2e)
#-- PATH-TOOLS
#-- AnyEditTools
#-- SubClipse
cd /opt/rcptt2.3.0.ide/rcptt
./rcptt \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository \
http://download.eclipse.org/releases/photon,\
http://cdn.rawgit.com/sandipchitale/pathtools/1.0.64/PathToolsUpdateSite/site.xml,\
http://andrei.gmxhome.de/eclipse/,\
https://dl.bintray.com/subclipse/releases/subclipse/4.2.x/ \
-installIUs \
org.eclipse.epp.mpc.feature.group,\
org.eclipse.m2e.feature.feature.group,\
PathToolsFeature.feature.group,\
AnyEditTools.feature.group,\
org.tigris.subversion.subclipse.feature.group \
-vmargs -Declipse.p2.mirrors=true -Djava.net.preferIPv4Stack=true
