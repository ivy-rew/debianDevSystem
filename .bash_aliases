alias http="python3 -m http.server"
alias vncHome="vncserver -localhost no -name home -geometry 1366x768 -xstartup /home/rew/.vnc/cinammon-anonymous-vnc  :1"
alias vncHomeKill="vncserver -kill :1"
alias eclipseDirector="/opt/eclipse.rcp.1812/eclipse -nosplash -application org.eclipse.equinox.p2.director -destination $PWD"
alias dockerPrune="docker system prune -a --volumes -f"
