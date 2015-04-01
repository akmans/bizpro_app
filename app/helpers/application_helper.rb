# encoding: utf-8

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title_help(page_title = '')
    base_title = 'オーディオPRO'
    if page_title.empty?
      base_title
    else
      title = page_title.split(',') << base_title
      title.join(' | ')
    end
  end

  # add commas to given string
  def commas_help(x)
    str = x.to_s.reverse
    str.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  # add hiffen to given string
  def hiffen_help(x)
    str = x.to_s.reverse
    str.gsub(/(\d{4})(?=\d)/, '\\1-').reverse
  end

  # generate month hash
  def month_hash_help
    month = {"" => "(月)"}
    (1..12).each do |m|
      month[m] = "#{m}月"
    end
    return month
  end

  # generate year hash
  def year_hash_help
    year = {"" => "(年)"}
    (2011..2015).each do |y|
      year[y] = "#{y}年"
    end
    return year
  end

  # generate is auction hash
  def is_auction_hash_help
    {"" => "(全部)", "0" => "非オーク品", "1" => "オーク品"}
  end

  # generate sold flag hash
  def undeal_product_sold_flg_help
    {"" => "(全部)", "0" => "未売却", "1" => "売却済"}
  end

  # generate undeal_auction hash
  def undeal_auction_hash_help
    {"" => "(全部)", "0" => "区分未登録", "1" => "商品未登録", "2" => "カス未登録"}
  end

  # generate undeal_custom hash
  def undeal_custom_hash_help
    {"" => "(全部)", "0" => "商品未登録"}
  end

  # generate shipment_status hash
  def shipment_status_hash_help
    {"" => "(全部)", "0" => "発送中", "1" => "到着済"}
  end
end
