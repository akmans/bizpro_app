class Modu < ActiveRecord::Base
  belongs_to :brand
  self.primary_key = "modu_id"

  default_scope -> { order(modu_id: :ASC) }

  validates :modu_id , # presence: true,
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

  before_create do
    self.modu_id = generate_modu_id if modu_id.blank?
  end

  private
    # generate modu id
    def generate_modu_id
      max_id = Modu.where(brand_id: self.brand_id).maximum(:modu_id)
      return "M" + self.brand_id + "001" if max_id.nil?
      next_id = max_id[4,6].to_i + 1
      return max_id[0..3] + next_id.to_s.rjust(3, '0')
    end
end
