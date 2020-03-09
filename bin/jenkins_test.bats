#!/usr/bin/env bats

setup(){
  . ./jenkinsOp.sh
}

@test "parseJson" {
  response='{"_class":"org.jenkinsci.plugins.workflow.job.WorkflowJob","color":"blue"}'
  val=$(jsonField "$response" "color")
  [ "$val" == "blue" ]
}

@test "loadBranches" {
  branches=$(getAvailableBranches)
  [[ " ${branches[@]} " =~ "master" ]] # contains master
}

@test "openDir" {
  skip "avoid opened file browser"
  . ./jenkinsGet.sh
  openDir .
}