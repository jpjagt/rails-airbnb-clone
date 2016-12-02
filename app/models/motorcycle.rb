class Motorcycle < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :reviews, through: :reservations, dependent: :destroy

  validates :brand, :model, :year, :city, :address, :license_plate, :price, presence: true
  validates :year, format: { with: /(19|20)\d{2}/,
    message: "the year should be 4 digits" }

  has_attachments :photos, maximum: 2

  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :geocode, if: :address_changed?
end
