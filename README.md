# Computational Photography
This repository has several interesting cv projects. 

### Table of Contents
**[Tiny Planet](#tiny-planet)**<br>
**[Face Morphing](#face-morphing)**<br>
**[Image Wrapping and Mosaic](#image-wrapping-and-mosaic)**<br>
**[Gradient-Domain Fusion](#gradient-domain-fusion)**<br>
**[Self-made Camera](#self-made-camera)**<br>
**[Colorizing the Prokudin-Gorskii photo collection](#colorizing-the-prokudin-gorskii-photo-collection)**<br>
**[Eulerian Video Magnification](#eulerian-video-magnification)**<br>

## Tiny Planet 
A program to convert a single photo or video to a "tiny plant" using polar coordinate system. A demonstration of the effect is shown below:

Flagstaff hill, Pittsburgh           |  Lake District, Scotland
:-------------------------:|:-------------------------:
![](https://i.vimeocdn.com/video/547827502.webp?mw=600&mh=527&q=70?raw=true)  |  ![](https://cloud.githubusercontent.com/assets/11666005/11861641/3fae4f96-a450-11e5-988c-614d520c0c0f.jpg)

Here is the detailed write-up of this project:
[Tiny Planet](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Tiny%20Planet/webpage.html)

## Face Morphing
Using Delaunay Triangulation to mesh up the face, I was able to apply face morphing to achieve a series of effects:

Average Face of the CV Class      |  Morphing between full human forms |  Extract principal components from an image
:-------------------------:|:-------------------------:|:-------------------------:
![](Face%20Morphing/web/imgs/meanFace_feathered.jpg)  |   <img src="Face%20Morphing/web/imgs/lyb.gif" width=1000px>|  ![](Face%20Morphing/web/imgs/pca/pc_5.jpg)

Here is the detailed write-up of this project:
[Face Morphing](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Face%20Morphing/web/webpage_proj4.html)

## Image Wrapping and Mosaic
This project does image mosaicing to make panoramic photos. It morphs the photos using perspective transformation and stitches the photos together to make a panoramic photo.

Cross roads part 1 |  Cross roads part 2 |  Cross roads panorama
:-------------------------:|:-------------------------:|:-------------------------:
![](https://cloud.githubusercontent.com/assets/11666005/11612245/4894860e-9bc0-11e5-987a-45c781350b26.JPG)  |   ![](https://cloud.githubusercontent.com/assets/11666005/11612247/4897a8c0-9bc0-11e5-8712-858148205151.JPG)|  ![](https://cloud.githubusercontent.com/assets/11666005/11612267/0166917c-9bc1-11e5-8701-8a8f0c72e223.jpg)

Here is a more detailed write-up of this project:
[Image Wrapping and Mosaic](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Image%20wrapping%20and%20mosaic/IMAGE%20WARPING%20and%20MOSAICING.html)

## Gradient-Domain Fusion
This project fuses one picture segment to another image but attains most of the gradients in the two images using Poisson blending.

Source Image |  Target Image |  Blend Image
:-------------------------:|:-------------------------:|:-------------------------:
![](Poisson%20blend/www/img/IMG_1342.JPG)  |   ![](Poisson%20blend/www/img/floral-paper-canvas-or-parchment.jpg)|  ![](Poisson%20blend/www/img/mixed2.jpg)

Here is a more detailed write-up of this project:
[Gradient-Domain Fusion](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Poisson%20blend/www/webpage_proj3.html)

## Self-made Camera
DIY camera device!

The set up|  Sample result 
:-------------------------:|:-------------------------:
![](Self-made%20camera/web_img/demo-device-outter.JPG)  | ![](Self-made%20camera/web_img/scene1-small.jpg)

Here is the set up parameters for the camera:
[Set up](https://github.com/elizazhi/computational-photography/blob/main/Self-made%20camera/params.txt)


## Colorizing the Prokudin-Gorskii photo collection
This project takes three channels (RGB) of the same image, aligns them properly, and outputs a color image.
Another key part of this image is image compressing and resizing using image pyramid.

R, G, B images|  Colored image 
:-------------------------:|:-------------------------:
![](Self-made%20camera/web_img/demo-device-outter.JPG)  | ![](Self-made%20camera/web_img/scene1-small.jpg)

Here is a more detailed write-up of this project:
[Colorizing the Prokudin-Gorskii photo collection](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Image%20Pyramid/webpage/webpage_proj1.html)

## Eulerian Video Magnification
This project visualizes subtle changes in the image through amplification of pixel colors in a certain frequency range.

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](https://youtu.be/A_DGq8ILpjo)
<iframe width="560" height="315" src="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Here is a more detailed write-up of this project:
[Eulerian Video Magnification](https://htmlpreview.github.io/?https://github.com/elizazhi/computational-photography/blob/main/Eulerian%20Video%20Magnification/web/webpage_proj2.html)
