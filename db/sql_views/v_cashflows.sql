DROP VIEW IF EXISTS v_cashflows;
CREATE VIEW v_cashflows AS
SELECT
  auction_id as flow_id,
  auction_name as flow_name,
  end_time as happen_date,
  sold_flg as is_in,
  CASE WHEN COALESCE(sold_flg, 0) = 0
    THEN (-1) * price * (COALESCE(tax_rate, 0) + 100) / 100 - COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)
    ELSE price - COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0) END as amount,
  1 as is_auction,
  1 as is_domestic
FROM auctions
WHERE not exists (SELECT *
                  FROM products, pa_maps
                  WHERE products.product_id = pa_maps.product_id
                  AND products.is_domestic = 0
                  AND pa_maps.auction_id = auctions.auction_id)
union
SELECT
  custom_id,
  custom_name,
  regist_date,
  '0',
   - COALESCE(net_cost, 0) - COALESCE(tax_cost, 0) - COALESCE(other_cost, 0) as price,
  0,
  1 as is_domestic
FROM customs
WHERE is_auction = 0;