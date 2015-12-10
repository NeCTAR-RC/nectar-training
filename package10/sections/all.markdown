---
layout: print
part: Documentation
---

{% assign pagedata = site.data.p10 %}
{% for packagepart in pagedata %}
## {{ packagepart.name }}
  {% assign basename = packagepart.file | split: '.' %}
  {% assign basename = basename[0] | append: '.markdown' %}

  {% capture includedfile %}
      {% include_relative {{basename}} %}
  {% endcapture %}
  {{ includedfile | stripfrontmatter }}
  
{% endfor %}
