#!/bin/bash
  
oneTimeSetUp(){
  . ./jenkinsOp.sh
}

test_parseJson(){
  response='{"_class":"org.jenkinsci.plugins.workflow.job.WorkflowJob","color":"blue"}'
  val=$(jsonField "$response" "color")
  assertEquals "blue" "$val"
}

skip_openDir(){
  . ./jenkinsGet.sh
  openDir .
}