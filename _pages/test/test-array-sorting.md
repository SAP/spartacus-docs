---
title: Testing Array Sorting
---

{% capture feature_names %}
{% for items in site.pages %}
  
    {% for item in items.feature %}
      {{ item.name }}
      {% if forloop.last == false %}::{% endif%}

    {% endfor %}
{% endfor %}
{% endcapture %}
{% assign features_array = feature_names | split: '::' | sort_natural %}

{{ features_array }}
