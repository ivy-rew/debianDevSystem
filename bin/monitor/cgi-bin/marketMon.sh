#!/bin/bash

org="axonivy-market"

ignored_repos=(
  "market-up2date-keeper"
  "market.axonivy.com"
  "market"
)

githubRepos() {
  curl --url "https://api.github.com/orgs/${org}/repos?per_page=100" \
    --header "Accept: application/vnd.github+json" \
    --header "Authorization: Bearer $GH_TOKEN"
}

collectRepos() {
  githubRepos | 
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
  if [[ " ${ignored_repos[@]} " =~ " $1 " ]]; then
    return
  fi
  repo=$1
  build="https://github.com/${org}/${repo}/actions/workflows/ci.yml"
  badge="${build}/badge.svg"
  echo "<li><a href='${build}'><img src='${badge}'/> ${repo}</a></li>"
}

page() {
  title="Action Monitor 4"
  css="<link type='text/css' rel='stylesheet' href='/monitor.css'>"
  echo "<html><head><title>${title} ${org}</title>${css}</head>"
  echo "<h3>${title} <a href='https://github.com/${org}'>${org}</a></h3>"
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
