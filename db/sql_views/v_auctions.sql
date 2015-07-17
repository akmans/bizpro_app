DROP VIEW IF EXISTS v_auctions;
CREATE VIEW v_auctions AS
SELECT
 auctions.auction_id,
 auctions.end_time,
 auctions.auction_name,
 auctions.url,
 auctions.sold_flg,
 auctions.ope_flg,
 CASE
  WHEN COALESCE(auctions.sold_flg, 0) = 0
  THEN (-1) * auctions.price * (COALESCE(auctions.tax_rate, 0) + 100) / 100 - COALESCE(auctions.payment_cost, 0) - COALESCE(auctions.shipment_cost, 0)
  ELSE auctions.price - COALESCE(auctions.payment_cost, 0) - COALESCE(auctions.shipment_cost, 0)
 END as price,
 cat.category_name,
 pa.product_id
FROM auctions
LEFT OUTER JOIN categories cat
 ON auctions.category_id = cat.category_id
LEFT OUTER JOIN pa_maps pa
 ON auctions.auction_id = pa.auction_id;