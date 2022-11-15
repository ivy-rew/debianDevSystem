#!/bin/bash

org="axonivy-market"

collectRepos() {
  curl "https://api.github.com/orgs/${org}/repos?per_page=100" | 
  jq -r '.[] | 
    select(.archived == false) | 
    select(.is_template == false) | 
    select(.default_branch == "master") | 
    select(.language != null) | 
    .name'
}

print() {
  collectRepos |
  while read repo_name; do
    status $repo_name
  done
}

status() {
  repo=$1
  build="https://github.com/${org}/${repo}/actions/workflows/ci.yml"
  badge="${build}/badge.svg"
  echo "<li><a href='${build}'><img src='${badge}'/> ${repo}</a></li>"
}

page() {
  echo "<html><link type='text/css' rel='stylesheet' href='/monitor.css'>"
  echo "<ul>"
  print
  echo "</ul>"
  echo "</html>"
}

localFile() {
  html="/tmp/marketmon.html"
  page > $html
  firefox $html
}

localPage() {
  echo "Content-type: text/html"
  echo ""
  page
}

localPage
