---
layout: default
title: publications
group: Publications
---

# Publications

{% for post in site.categories[page.title] %}
{% include post_link.html %}
{% endfor %}
