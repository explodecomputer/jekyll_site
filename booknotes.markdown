---
layout: default
title: Booknotes
group: Booknotes
---
<style>
h1 {
    text-align: left;
}
</style>

# Booknotes

{% for category in site.categories %}
{% assign group = category[0] | category_group %}
{% if group == 'booknotes' %}
<h4><a href="/{{ category[0] }}.html">{{ category[0] | parse_category }}</a></h4>
{% for post in category[1] %}
{% include booknotes_link.html %}
{% endfor %}

{% endif %}

{% endfor %}
