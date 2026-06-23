+++
title = "A bunch of Mandelbrot Set renders"
description = "My recent hyperfixation"
taxonomies.tags = ["math", "development"]
date = "2025-10-13"
+++

# What's a Mandelbrot Set
A fractal. A cool fractal. I really like fractals. Basically you have this equation:  

\\[z\_{n+1}=z\_{n}^2+C\\]  

By its look, it's not really that hard now is it? Lets say, you:  

1. Evaluate this expression like 5 thousand times (the more the better) for each value of \\(C\\) on the complex plane (which basically allows us to pack two numbers into a single variable, very useful and makes the expression above look much more readable and less scary);  

2. Check if the resulting value of \\(Z_{n}\\), or actually its magnitude (in case of complex numbers, remember: we're packing two in one) goes up to infinity (actually past \\(4.0\\) but we don't talk about that);  

3. If it doesn't, you paint the pixel for the value of \\(C\\) black, otherwise you either paint it fully white, or (in my case, I like my fractals shiny and colorful) add some coloring;  

And when you do that, you get this:  

![](00001_F32.bmp.png)  

# Zooming in
It's a fractal though, so we can infinitely zoom in:  

![](02350_F32.bmp.png)  

Lets zoom in a little bit more, say uhhh.... to \\(984609\\):  

![](02600_F32.bmp.png)  

Now what pixelated mess of fractals do we have here?  

# Pixelation
As it turns out, 32-bit floating point precision is not quite enough to do large zoom-ins, so lets render the exact same zoom factor with double-recision (64-bit) floating point numbers:  

![](02600_F64.bmp.png)  

There we go, now it's much less pixelated...

# Some pictures
I passed these through [RITEG](https://untodesu.codeberg.page/riteg) and in my opinion these are the prime wallpaper material:  

![](mandelbrot1.png)  
![](mandelbrot2.png)  
![](mandelbrot3.png)  

# A video
Comparing zoom factors is better when actual zoom-in is animated, so here's a YouTube video: [link](https://youtu.be/9fJk0ewLCBI)  
