---
layout: print
part: Documentation
---

{% assign pagedata = site.data.p01 %}
{% for packagepart in pagedata %}
## {{ packagepart.name }}
  {% assign basename = packagepart.file | split: '.' %}
  {% assign basename = basename[0] | append: '.markdown' %}
  {% include_relative {{basename}} %}
{% endfor %}
