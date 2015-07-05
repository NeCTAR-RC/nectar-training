---
layout: post
title: README 
---

# nectar-training

To clone this repository use:

```git clone git@github.com:IntersectAustralia/nectar-training.git```

Then:


1. Install ```rbenv```
2. Use ```rbenv``` to install ruby 2.2.2
3. Then do:

```bundle install```

To generate the html content use:

```bundle exec jekyll serve```

Then browse to [http://localhost:4000](http://localhost:4000)


# Notes for developers of the layouts and content

**Sections** 

The documentation is built such that each package (module) can have
several sections. This avoids very long HTML pages which have to be
scrolled through, and introduces the convenience of a navigation (in
the style of table of contents) so that it is easy to jump to a certain
part of the module.
  The implementation is as follows:
  - *_data/p01.yml .. _data/p10.yml (10 files, one for each package)* contains the structure of the
  module as a YAML list. For each structure, <title> (name) and <file> name has to be given here.
  Optionally, a field called <level> may be added, which will create a hierarchy (from top to bottom),
  starting with level 1 as top-level.
  The file name should be only the html file (without a path), and has to be located in a folder
  named *sections* within the module, e.g. *package01/sections*. 
    This was found the most convenient to specify the structure in variables without having to specify them
  in each markup file (it is not possible to import yaml files from within the frontmatter).
  - *_layout/package-part-ext.html* contains a simple first simple implementation of generating the
  navigation module. It uses the structure specified in the *_data/p0x.yml* file to generate the links.
  Levels higher than 1 are only displayed if one of the files under the top-level element are being displayed.

**Background boxes**

A plugin was developed to insert *Info boxes* with the block tag
 
```{% raw %} {% BgBox <type> %} Text of info box {% endBgBox %} {% endraw %}```
  
Replacing *&lt;type&gt;* with either

* info
* important 
* definition
* edit
* terminal
* prerequisite

to create the following two styles:
{% BgBox info %}
This is an information box 
{% endBgBox %}

{% BgBox important %} 
This is a box with important information 
{% endBgBox %}

{% BgBox definition %} 
This is a box with a definition 
{% endBgBox %}

{% BgBox edit %}
This formatting displays contents of a file   
{% endBgBox %}

{% BgBox terminal %}
NectarTrainingPC:~ Jennifer$ whoami    
Jennifer
{% endBgBox %}

{% BgBox prerequisite %}
This is a box for a prerequisite
{% endBgBox %}


The implementation is as follows:
 
  - *css/main.scss* contains the style classes bgInfo and bgImportant which define some characteristics of the box.
  - *_plugins/background_box_plugin.rb* is the plugin. The little image is inserted here instead of in the style sheet, so that the text can flow around it.


**Images**

A plugin was developed to format images (e.g. width and alignment).     
```{% raw %} 
{% img src=</path/to/image>, w=<width>, h=<height>, alt=<alt text> dim=<px|percent>, css=<extra css formatting> %}
{% endraw %}```    
All attributes except src are optional. Each argument has to be separated with a ','.
The dimension (argument dim) defines whether width is specified in pixels or percent of 
The page width (default: px). Height is always in pixels, unless unspecified (then it is autscaled with width)    
See *_plugins/image.rb*.


