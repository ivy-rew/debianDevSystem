#!/bin/bash
  
oneTimeSetUp(){
  . ../jenkinsOp.sh
}

testParseJson(){
  response='{"_class":"org.jenkinsci.plugins.workflow.job.WorkflowJob","color":"blue"}'
  val=$(jsonField "$response" "color")
  assertEquals "blue" "$val"
}
