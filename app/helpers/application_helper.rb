# encoding: utf-8

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'オーディオPRO'
    if page_title.empty?
      base_title
    else
      title = page_title.split(',') << base_title
      title.join(' | ')
    end
  end
end
