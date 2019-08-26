#!/bin/bash

ECLIPSE_HOME=/opt/eclipse.rcp.1812/
if [ ! -z "$1" ]
  then
    ECLIPSE_HOME=$1
fi

cd "$ECLIPSE_HOME"
sudo ./eclipse \
-application org.eclipse.equinox.p2.director \
-clean -purgeHistory \
-noSplash \
-repository \
http://download.eclipse.org/releases/latest,\
http://cdn.rawgit.com/sandipchitale/pathtools/1.0.64/PathToolsUpdateSite/site.xml,\
http://andrei.gmxhome.de/eclipse/,\
https://dl.bintray.com/subclipse/releases/subclipse/4.2.x/,\
https://ecd-plugin.github.io/update/ \
-installIUs \
org.eclipse.wb.rcp.feature.feature.group,\
PathToolsFeature.feature.group,\
AnyEditTools.feature.group,\
org.tigris.subversion.subclipse.feature.group,\
org.tigris.subversion.clientadapter.svnkit.feature.feature.group,\
\
org.sf.feeling.decompiler,\
org.sf.feeling.decompiler.cfr,\
org.sf.feeling.decompiler.jad,\
org.sf.feeling.decompiler.jd,\
org.sf.feeling.decompiler.procyon \
-vmargs -Declipse.p2.mirrors=true -Djava.net.preferIPv4Stack=true

#fix permission issue: eclipse not startable es installed plugins are owned by root
ECLIPSE_OWNER=`stat -c %U $ECLIPSE_HOME`
sudo chown -R $ECLIPSE_OWNER:$ECLIPSE_OWNER $ECLIPSE_HOME

