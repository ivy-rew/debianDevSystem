#/bin/bash

collectRepos() {
  curl https://api.github.com/orgs/axonivy-market/repos?per_page=100 | 
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
  badge=https://github.com/axonivy-market/${repo}/actions/workflows/ci.yml/badge.svg
  build=https://github.com/axonivy-market/${repo}/actions/workflows/ci.yml
  echo "<li><a href='${build}'><img src='${badge}'/> ${repo}</a></li>"
}

page() {
  echo "<html><ul>"
  print
  echo "</ul></html>"
}

html="/tmp/marketmon.html"
page > $html
firefox $html