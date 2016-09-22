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
3. Use ```rbenv``` to make ruby 2.2.2 the active version
4. Then do:

```bash
gem install bundler
bundle install
```

A known issue when installing libv8 -v 3.16.14.7 on later versions of OSX is that the compiler chokes. 
If you are on OSX and  seeing an exception and the message 
```Make sure that `gem install libv8 -v '3.16.14.7'` succeeds before bundling.```
you can run the following command to avoid the compilation step:

```bash
gem install libv8 -v '3.16.14.7' -- --with-system-v8
``` 

Don't forget re-run the ```bundle install``` command if you were forced to install libv8 manually. 

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
  module as a YAML list. Each list entry is a map with at least two keys: **title** and **file**.
  Optionally, a field called **level** may be added, which will create a hierarchy (nesting of menu entries),
  starting with level 1 as top-level.
  The file name should be only the html file (without a path), and has to be located in a folder
  named *sections* within the module, e.g. *package01/sections*.    

   Another optional field is **extra** (and extra_title along with it), which is to be a list of maps with two keys each: **title** and **file**, to link to another sub category. This is to generate an extra menu which is not part of the main contents list. This was only a trial and is not used at the moment any more. Implementation can be found in _layouts/package-part-ext-subcat.html.    

    This was found the most convenient to specify the structure in variables without having to specify them
  in each markup file (it is not possible to import yaml files from within the frontmatter).

- *_layout/package-part-ext.html* contains a simple first simple implementation of generating the
  navigation module. It uses the structure specified in the *_data/p0x.yml* file to generate the links.
  Levels higher than 1 are only displayed if one of the files under the top-level element are being displayed.

- *_layout/package-part-ext-subcat.html* is inherited from package-part-ext.html, but supports the "extra" field to generate an extra menu.

**Background boxes**

A plugin was developed to insert *Info boxes* with the block tag
 
```{% raw %} {% BgBox [type] %} Text of info box {% endBgBox %} {% endraw %}```
  
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
{% img src=[/path/to/image], w=[width], h=[height], alt=[alt text] dim=[px|percent], css=[extra css formatting] %}
{% endraw %}```    
All attributes except src are optional. Each argument has to be separated with a ','.
The dimension (argument dim) defines whether width is specified in pixels or percent of 
The page width (default: px). Height is always in pixels, unless unspecified (then it is autscaled with width)    
See *_plugins/image.rb*.


