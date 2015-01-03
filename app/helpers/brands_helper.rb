# encoding: utf-8
module BrandsHelper
  # return brand name by brand id
  def brand_name_help(brand_id)
    (Brand.find(brand_id).brand_name if Brand.exists?(brand_id)) || '-'
  end

  # return brand hash
  def brand_hash_help
    brands = {"" => "(空白)"}
    Brand.all.each do |bb| 
      brands.merge! bb.as_hash
    end
    return brands
  end
end
