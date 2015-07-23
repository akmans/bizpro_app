DROP VIEW IF EXISTS v_customs;
CREATE VIEW v_customs AS
SELECT
 customs.custom_id,
 customs.custom_name,
 customs.auction_id,
 customs.regist_date,
 pc_maps.product_id,
 customs.cancel_flg,
 customs.is_auction,
 CASE WHEN pc_maps.custom_id is null THEN '未' ELSE '-' END as regist_status
FROM customs
LEFT OUTER JOIN pc_maps
 ON customs.custom_id = pc_maps.custom_id;