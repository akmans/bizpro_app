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
end
