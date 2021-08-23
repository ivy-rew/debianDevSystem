alias http="python3 -m http.server"
alias vncHome="vncserver -localhost no -name home -geometry 1366x768 -xstartup /home/rew/.vnc/cinammon-anonymous-vnc  :1"
alias vncHomeKill="vncserver -kill :1"
alias eclipseDirector="/opt/eclipse.rcp.1812/eclipse -nosplash -application org.eclipse.equinox.p2.director -destination $PWD"
alias dockerPrune="docker system prune -a --volumes -f"

alias javaHome11="export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/"
alias javaHome8="export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/"
