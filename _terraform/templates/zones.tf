{%- for zone in [zone_oefd_ca, zone_oefd_net, zone_dtkerr_ca, zone_xnr_ca] -%}
{%- set zone_token = zone.name|no_dot|normalize_domain -%}
resource "digitalocean_domain" "{{ zone_token }}" {
  name = "{{ zone.name|no_dot }}"
}

{% for record in zone.records %}
resource "digitalocean_record" "{{ record|hash(zone_token) }}" {
  domain = digitalocean_domain.{{ zone_token }}.name
  type = "{{ record.type }}"
  name = "{{ record.host }}"
  value = "{{ record.value }}"
  ttl = {{ record.ttl }}
  {%- if record.port is defined %}
  port = {{ record.port }}
  {%- endif %}
  {%- if record.priority is defined %}
  priority = {{ record.priority }}
  {%- endif %}
  {%- if record.weight is defined %}
  weight = {{ record.weight }}
  {%- endif %}
  {%- if record.flags is defined %}
  flags = {{ record.flags }}
  {%- endif %}
  {%- if record.tag is defined %}
  tag = "{{ record.tag }}"
  {%- endif %}
}
{% endfor %}
{% endfor %}
