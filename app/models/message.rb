class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader

  validate :avoid_empty_message

  def time
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def avoid_empty_message
    errors.add(:body, "を入力してください") if body.blank? && image.blank?
  end

end
