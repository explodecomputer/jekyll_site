---
layout: default
title: zinnbook
group: Booknotes
---

<style>
h1 {
    text-align: right;
}

</style>

## *"A people's history of the United States of America"* by Howard Zinn


{% for post in site.categories[page.title] %}
{% include post_link.html %}
{% endfor %}
