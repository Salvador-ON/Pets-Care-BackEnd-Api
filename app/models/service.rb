class Service < ApplicationRecord
  has_many :appointments, dependent: :destroy
  validates_presence_of :price, :image_url, :schedule

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: true }

  validates :description, presence: true, length: { maximum: 250 }
end
