alias http="python3 -m http.server"

alias vncSession="vncserver -localhost no -name home -xstartup $HOME/.vnc/cinammon-anonymous-vnc"
alias vncHome="vncSession -geometry 1366x768  :1"
alias vncHomeKill="vncserver -kill :1"

alias eclipseDirector="/opt/eclipse.rcp.1812/eclipse -nosplash -application org.eclipse.equinox.p2.director -destination $PWD"
alias dockerPrune="docker system prune -a --volumes -f"

alias javaHome11="export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/"
alias javaHome8="export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/"
