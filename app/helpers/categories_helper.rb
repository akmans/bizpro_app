# encoding: utf-8
module CategoriesHelper
  # return category name by category id
  def category_name_help(category_id)
    (Category.find(category_id).category_name if Category.exists?(category_id)) || '-'
  end

  # return category hash
  def category_hash_help
    categories = {"" => "(空白)"}
    Category.all.each do |cc| 
      categories.merge! cc.as_hash
    end
    return categories
  end
end
