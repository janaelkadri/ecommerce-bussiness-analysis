# 📘 Data Dictionary — Olist E-Commerce Dataset

## customers_dataset
- customer_id : Unique ID per customer
- customer_unique_id : Same customer across multiple orders
- customer_zip_code_prefix : ZIP prefix
- customer_city : City name
- customer_state : State abbreviation

## orders_dataset
- order_id : Unique order ID
- customer_id : Customer who placed the order
- order_status : Status (delivered, shipped, canceled, etc.)
- order_purchase_timestamp : When the order was placed
- order_approved_at : Payment approval time
- order_delivered_carrier_date : When seller handed to carrier
- order_delivered_customer_date : Delivery time
- order_estimated_delivery_date : Estimated delivery date

## order_items_dataset
- order_id : Order identifier
- order_item_id : Item number within the order
- product_id : Purchased product
- seller_id : Seller fulfilling the item
- shipping_limit_date : Shipping deadline
- price : Item price
- freight_value : Shipping cost

## order_payments_dataset
- order_id : Order identifier
- payment_sequential : Payment attempt number
- payment_type : credit_card, boleto, voucher, etc.
- payment_installments : Number of installments
- payment_value : Payment amount

## order_reviews_dataset
- review_id : Review unique ID
- order_id : Order identifier
- review_score : Score from 1 to 5
- review_comment_title : Short title
- review_comment_message : Review text
- review_creation_date : Review written
- review_answer_timestamp : Seller or system response

## products_dataset
- product_id : Unique product ID
- product_category_name : Portuguese category
- product_name_length : Text length of name
- product_description_length : Text length of description
- product_photos_qty : # of photos
- product_weight_g : Weight
- product_length_cm : Length
- product_height_cm : Height
- product_width_cm : Width

## sellers_dataset
- seller_id : Unique seller ID
- seller_zip_code_prefix : ZIP prefix
- seller_city : City
- seller_state : State

## geolocation_dataset
- geolocation_zip_code_prefix : ZIP prefix
- geolocation_lat : Latitude
- geolocation_lng : Longitude
- geolocation_city : City
- geolocation_state : State

## product_category_translation
- product_category_name : Portuguese category
- product_category_name_english : English translation
