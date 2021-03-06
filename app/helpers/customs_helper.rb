#encoding: utf-8
include AuctionsHelper

module CustomsHelper
  # return percentage hash
  def percentage_hash_help
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

  # return action percentage hash
  def auction_percentage_hash_help(custom_id, auction_id)
    rtn = {"" => "(空白)"}
    i = 10
    # get current percentage
    currentCustom = Custom.select(:percentage).where(custom_id: custom_id).where(auction_id: auction_id).first
    currentPercentage = 0
    currentPercentage = currentCustom.percentage unless (currentCustom.nil? || currentCustom.percentage.nil?)
    # caculate percentage
    per = 100 - Custom.where(auction_id: auction_id).sum(:percentage).to_i
    per = per > currentPercentage ? per : currentPercentage if currentPercentage > 0
    while i <= per and i < 100 do
      thash = {i.to_s => percentage_hash_help[i.to_s]}
      rtn.merge! thash
      i += 10
    end
    return rtn
  end

  # return percentage name
  def percentage_name_help(key)
    key.blank? ? "-" : percentage_hash_help[key.to_s]
  end

# delete 2015.06.21 reason: not shown on page custom show
#  # is_auction_name
#  def is_auction_name_help(key)
#     key.blank? ? "-" : (key == 1 ? "オークション品" : "-")
#  end

  # custom_total_cost
  def custom_total_cost_help(custom_id)
    custom = Custom.find(custom_id)
    return (custom.net_cost + custom.tax_cost + custom.other_cost).to_i * -1 if custom.is_auction == 0
    return 0 if custom.auction_id.blank?
    auction = Auction.find(custom.auction_id)
    (auction_total_cost_help(auction) * (custom.percentage || 0) / 100).to_i
  end

  # return custom name by custom id
  def custom_name_help(custom_id)
    Custom.find(custom_id).custom_name
  end

  # return custom hash
  def customs_hash_help
    c_hash = {"" => "(空白)"}
    Custom.where.not(custom_id: PcMap.all).each do |custom|
      akey = custom.custom_id
      avalue = custom.custom_name
      new_hash = { akey => avalue}
      c_hash.merge! new_hash
    end
    return c_hash
  end
end
