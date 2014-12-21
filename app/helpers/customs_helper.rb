#encoding: utf-8
include AuctionsHelper

module CustomsHelper
  
  # percentage_hash
  def percentage_hash
    {""   => "(空白)",
     "10" => "１０％",
     "20" => "２０％",
     "30" => "３０％",
     "40" => "４０％",
     "50" => "５０％",
     "60" => "６０％",
     "70" => "７０％",
     "80" => "８０％",
     "90" => "９０％"
    }
  end
  
  # percentage_name
  def percentage_name(key)
    key.blank? ? "-" : percentage_hash[key.to_s]
  end
  
  # is_auction_name
  def is_auction_name(key)
     key.blank? ? "-" : (key == 1 ? "オークション品" : "-")
  end
  
  # custom_total_cost
  def custom_total_cost
    return @custom.net_cost + @custom.tax_cost + @custom.other_cost if @custom.is_auction == 0
    return 0 if @custom.auction_id.blank?
    @auction = Auction.find(@custom.auction_id)
    (auction_total_cost * @custom.percentage / 100).to_i
  end
end
