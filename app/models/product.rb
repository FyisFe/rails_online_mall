class Product < ApplicationRecord

  validates :category_id, presence: { message: "Category must not be empty" }
  validates :title, presence: { message: "Title mush not be empty" }
  validates :status, inclusion: { in: %w[on off], 
    message: "The status of the product mush be on | off" }
  validates :amount, numericality: { only_integer: true,
    message: "Amount mush be an integet!" },
    if: proc { |product| !product.amount.blank? }
  validates :amount, presence: { message: "Amount must not be empty" }
  validates :msrp, presence: { message: "MSRP mush not be empty" }
  validates :msrp, numericality: { message: "MSRP mush be a number" },
    if: proc { |product| !product.msrp.blank? }
  validates :price, numericality: { message: "Price must be a number" },
    if: proc { |product| !product.price.blank? }
  validates :price, presence: { message: "Price must not be empty" }
  validates :description, presence: { message: "Description must not be empty" }

  belongs_to :category
  has_many :product_images, -> { order(weight: 'desc') }, dependent: :destroy


  before_create :set_default_attrs

  module Status
    On = 'on'
    Off = 'off'
  end

  private
  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end
end