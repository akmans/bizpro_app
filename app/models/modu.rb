class Modu < ActiveRecord::Base
  belongs_to :brand
  self.primary_key = "modu_id"
  
  default_scope -> { order(modu_id: :ASC) }
  
  validates :modu_id , presence: true,
                       length: { maximum: 7},
                       uniqueness: {case_sensitive: false }
  validates :modu_name, presence: true, length: { maximum: 100}
  validates :brand_id, presence: true,
                       length: { maximum: 4}
  
  def as_hash
    {self.modu_id => self.modu_name}
  end
  
  def as_json(options={})
    super(:only => [:modu_id, :modu_name])
  end
end
