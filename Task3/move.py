#!/usr/bin/env python

import pyson
import pyson.runtime
import pyson.stdlib
import random

import os

locations={}

actions = pyson.Actions(pyson.stdlib.actions)

@actions.add(".sense_location",2)
def sense_location(agent,term,intention):
  (x,y)=locations[agent]
  pyson.unify(x,term.args[0],intention.scope,intention.stack)
  pyson.unify(y,term.args[1],intention.scope,intention.stack)
  yield
  #l=pyson.Literal("at",(x,y))
  #pyson.runtime.add_belief(l,agent,intention)
  #yield

@actions.add(".north",0)
def north(agent,term,intention):
  (x,y)=locations[agent]
  y=y+random.randint(1,2)
  locations[agent]=(x,y)
  yield

@actions.add(".south",0)
def south(agent,term,intention):
  (x,y)=locations[agent]
  y=y-random.randint(1,2)
  locations[agent]=(x,y)
  yield

@actions.add(".east",0)
def east(agent,term,intention):
  (x,y)=locations[agent]
  x=x+random.randint(1,2)
  locations[agent]=(x,y)
  yield

@actions.add(".west",0)
def west(agent,term,intention):
  (x,y)=locations[agent]
  x=x-random.randint(1,2)
  locations[agent]=(x,y)
  yield

@actions.add(".pickup",0)
def pickup(agent,term,intention):
  if locations[agent] in garbage and garbage[locations[agent]]>0 and holding[agent]<2:
    holding[agent]+=1
    garbage[locations[agent]]-=1
  yield

@actions.add(".drop",0)
def drop(agent,term,intention):
  if locations[agent] not in garbage:
    garbage[locations[agent]]=0
  if holding[agent]>0:  
    garbage[locations[agent]]+=1
    holding[agent]-=1
  yield

@actions.add(".incinerate",0)
def incinerate(agent,term,intention):
  if agent==incin:
    garbage[(0,0)]=0
  yield

@actions.add(".check_for_garbage",0)
def check_for_garbage(agent,term,intention):
  (x,y)=locations[agent]
  for (gx,gy) in garbage:
    if garbage[(gx,gy)]>0 and abs(x-gx)<=1 and abs(y-gy)<=1:
      l=pyson.Literal("garbage",(gx,gy))
      pyson.runtime.add_belief(l,agent,intention)
  yield

env = pyson.runtime.Environment()

garbage={}
for i in range(0,10):
  for j in range(0,10):
    garbage[(i,j)]=0

for i in range(0,10):
  garbage[(random.randint(1,9),random.randint(1,9))]+=1
  
holding={}
incin=None

with open(os.path.join(os.path.dirname(__file__),"singlecleaner.asl")) as source:
  agent = env.build_agents(source,1,actions)
  locations[agent[0]]=(random.randint(1,10),random.randint(1,10))
  holding[agent[0]]=0
  (x,y)=locations[agent[0]]
  l=pyson.Literal("at",(x,y))
  pyson.runtime.add_belief(l,agent[0],pyson.runtime.Intention())

with open(os.path.join(os.path.dirname(__file__),"incinerator.asl")) as source:
  incin=env.build_agent(source,actions)
  agent.append(incin)

if __name__=="__main__":
  env.run()
