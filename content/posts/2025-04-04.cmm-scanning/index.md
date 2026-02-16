+++
title = "A very abridged CMM scanning illustration"
description = "I like to draw things to explain things"
taxonomies.tags = ["development", "caq"]
date = "2025-04-04"
+++

> **NOTE:** this is by no means a good explanation, I work in a metrology-adjacent sphere, more specifically we're figuring out how CAQ software works and develop our own, so all this "logic" is explained in terms we the programmers have figured out ourselves  

One day I was asked by a bloke at work to explain how scanning works from the hardware point of view. So I drew them a diagram; after some time I decided it's not worth it to keep it private and decided to make a small blog post that contains an abridged explanation of how scanning works.  

So here's the diagram:  

![image_2025-03-26_15-40-00.png](image_2025-03-26_15-40-00.png)  

- Basically, the CMM starts by looking up a surface at _Ps_ point  
- After that, it begins moving in the direction of _Vd_  
- Whilst moving, the probe head detects changes in "altitude" and calls back to the positioning system to either raise or lower the probe itself  
- While doing this, the CMM's brains (or an I++ DME server for what one is concerned) decimate and accumulate data with _StepW_ as an average distance between two points. Mind you, if you specify zero for that value, DME server is going to dump literally anything it gets without any filtering  
- Also the brains control when to stop. In the image, I drew a plane (projected to the screen as a line, there is a point _Pe_ that is _on the plane_ and the plane is oriented at _Ve_). When the read probe position crosses this boundary a set amount of times, the command is considered finished.  
