class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader

  validate :avoid_empty_message

  def time
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def avoid_empty_message
    if body.blank? && image.blank?
      errors.add(:body, "を入力してください")
    end
  end

end
