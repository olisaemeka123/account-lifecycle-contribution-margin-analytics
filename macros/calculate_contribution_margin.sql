{% macro calculate_contribution_margin(fee_revenue_column, monthly_cost_column) %}
coalesce({{ fee_revenue_column}}, 0) - coalesce({{ monthly_cost_column}}, 0)
{% endmacro %}