# The name of this view in Looker is "products".
view: products {
  # The sql_table_name parameter indicates the underlying database table to be used for all fields in this view.
  sql_table_name: `bigquery-public-data.thelook_ecommerce.products` ;;

  #PRO TIP: The order of the field definitions within a view doesn't matter.
  # Organize fields in a way that makes sense for your organization.


  # In LookML there are two main types of fields, dimensions and measures.
  #   A dimension is a groupable field and can be used to filter query results.
  #   Here's what a standard dimension looks like in LookML:
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes"
      icon_url: "http://www.google.com/favicon.ico"
    }
  }


  # Let's break this down and take a closer look at the LookML for a dimension:
  # This dimension will be called "id" within Looker
  dimension: id {

    # This id column is the unique key for this table in the underlying database.
    primary_key: yes

    # This column is numeric (an integer) in the underlying database table.
    type: number

    # The underlying column in the products database table is called "id".
    # The ${TABLE} syntax references the table stated in the sql_table_name parameter.
    sql: ${TABLE}.id ;;

    # PRO TIP: If you need to change the underlyng table, you can do it once and have it
    # propagate through to all fields.
  }


  # Exercise:
  #           Update the product margin dimension sql to use substitution syntax rather
  #           than referencing the underlying database table.

  dimension: product_margin {
    type: number
    sql: ${TABLE}.retail_price - ${TABLE}.cost ;;
  }

  dimension: name {
    # You can add a label to a field which changes how it displays to users in the Explore
    label: "Product Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    # You can add a description to fields so users know what they represent
    description: "The cost of an item, in US dollars"
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    # You can use native SQL functions to transform data or make calculations
    type: number
    sql: CAST(${TABLE}.distribution_center_id AS INT64) ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  # A measure is a field that uses a SQL aggregate function, such as COUNT, SUM, AVG, MIN, or MAX.
  measure: count {
    label: "Number of Products"
    type: count
    drill_fields: [id, name]
  }
}
