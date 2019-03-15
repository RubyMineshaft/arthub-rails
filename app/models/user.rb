class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_one_attached :resume
  has_many :artworks

  validates :email, uniqueness: :true,
                    presence: :true
  validates :password, presence: :true, on: :create

  def grab_image(image_url)
    downloaded_image = open(process_uri(image_url))
    self.avatar.attach(io: downloaded_image  , filename: "profile.jpg")
  end

  private

  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end
end
