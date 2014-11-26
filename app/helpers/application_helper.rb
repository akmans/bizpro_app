# encoding: utf-8

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'オーディオPRO'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def subtitle(branch = '')
    return branch + " | マスタ管理" if (branch == 'カテゴリー' \
                                        or branch == 'ブランド' \
                                        or branch == '支払い方法' \
                                        or branch == '発送方法' \
                                        or branch == 'モデル')
    return branch
  end
end
