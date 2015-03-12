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
      ms = m.to_s.rjust(2, "0")
      month[ms] = "#{ms}月"
    end
    return month
  end

  # generate year hash
  def year_hash_help
    year = {"" => "(年)"}
    (2012..2015).each do |y|
      year[y] = "#{y}年"
    end
    return year
  end

  # generate sold type hash
#  def sold_type_hash_help
#    year = {"" => "(全部)"}
#    year.merge!(sold_type_hash_help)
#    return year
#  end
end
