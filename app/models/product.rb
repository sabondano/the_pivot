class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :seller
  has_many :auctions

  before_validation :set_default_image
  validates :name, :description, :category_id, presence: true

  scope :category_id, -> (category_id) { where category_id: category_id }

  private

  def set_default_image
    self.image_url = "default_image.jpg" if image_url && image_url.empty?
  end
end
