DROP VIEW IF EXISTS v_products;
CREATE VIEW v_products AS
SELECT
 pro.product_id,
 pro.product_name,
 pro.is_domestic,
 pro.exchange_rate,
 pro.category_id,
 pro.brand_id,
 pro.modu_id,
 pro.memo,
 pro.sold_date,
 (select count(*) from pa_maps pa where pa.product_id = pro.product_id) as auction_cnt,
 (select count(*) from pa_maps pa, auctions ac where pa.auction_id = ac.auction_id and pa.product_id = pro.product_id and ac.sold_flg = 0) as auction_cost_cnt,
 (select count(*) from pc_maps pc where pc.product_id = pro.product_id) as custom_cnt,
 (select count(*) from shipment_details sd where sd.product_id = pro.product_id) as shipment_cnt,
 (select count(*) from solds ss where ss.product_id = pro.product_id) as sold_cnt,
 (select sum(auc.price * (COALESCE(auc.tax_rate, 0) + 100) / 100 + COALESCE(auc.payment_cost, 0) + COALESCE(auc.shipment_cost, 0))
  from auctions auc
  where auc.sold_flg = 0 and auc.auction_id in (select auction_id from pa_maps pa where pa.product_id = pro.product_id)) as auc_cost,
 (select sum(auc.price - COALESCE(auc.payment_cost, 0) - COALESCE(auc.shipment_cost, 0))
  from auctions auc
  where auc.sold_flg = 1 and auc.auction_id in (select auction_id from pa_maps pa where pa.product_id = pro.product_id)) as auc_in,
  (select
    sum(CASE
        WHEN COALESCE(cus.is_auction, 0) = 0
        THEN (COALESCE(cus.net_cost, 0) + COALESCE(cus.tax_cost, 0) + COALESCE(cus.other_cost, 0))
        ELSE cus.percentage * (select CASE
                                      WHEN COALESCE(auc.sold_flg, 0) = 0
                                      THEN auc.price * (COALESCE(auc.tax_rate, 0) + 100) / 100 + COALESCE(auc.payment_cost, 0) + COALESCE(auc.shipment_cost, 0)
                                      ELSE auc.price - COALESCE(auc.payment_cost, 0) - COALESCE(auc.shipment_cost, 0)
                                      END as price from auctions auc where auc.auction_id = cus.auction_id) / 100
        END)
  from customs cus
  where cus.custom_id in (select custom_id from pc_maps pc where pc.product_id=pro.product_id)) as cus_cost,
 (select
   sum(COALESCE(sd.ship_cost, 0) + COALESCE(sd.insured_cost, 0))
  from shipment_details sd
  where sd.product_id = pro.product_id) as shipment_cost_jpy,
 (select
   sum(COALESCE(sd.custom_cost, 0))
  from shipment_details sd
  where sd.product_id = pro.product_id) as shipment_cost_rmb,
 (select
   sum(COALESCE(ss.sold_price, 0) - COALESCE(ss.ship_charge, 0) - COALESCE(ss.other_charge, 0))
  from solds ss
  where ss.product_id = pro.product_id) as sold_rmb
FROM products pro;