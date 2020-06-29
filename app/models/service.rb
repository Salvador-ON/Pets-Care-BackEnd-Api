class Service < ApplicationRecord
  has_many :appointments
  validates_presence_of :price, :image_url, :schedule

  validates :name, presence: true, length: { maximum: 30 }

  validates :description, presence: true, length: { maximum: 250 }
end
