#!/bin/bash
  
oneTimeSetUp(){
  . ./jenkinsOp.sh
}

test_parseJson(){
  response='{"_class":"org.jenkinsci.plugins.workflow.job.WorkflowJob","color":"blue"}'
  val=$(jsonField "$response" "color")
  assertEquals "blue" "$val"
}

test_loadBranches(){
  branches=$(getAvailableBranches)
  #no arrays support in posix :-/ ....
  #assertEquals "ivy-core_ci" ${branches}
}

skip_openDir(){
  . ./jenkinsGet.sh
  openDir .
}