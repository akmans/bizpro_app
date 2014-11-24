# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# カテゴリーデータ
(101..200).each do |n|
  category_id = "C#{n}"
  category_name = "カテゴリー #{n}"
  Category.create!(category_id: category_id, category_name: category_name)
end

# ブランドデータ
(101..200).each do |n|
  brand_id = "B#{n}"
  brand_name = "ブランド #{n}"
  Brand.create!(brand_id: brand_id, brand_name: brand_name)
end

# 支払い方法データ
(101..200).each do |n|
  paymethod_id = "P#{n}"
  paymethod_name = "支払い方法 #{n}"
  Paymethod.create!(paymethod_id: paymethod_id, paymethod_name: paymethod_name)
end