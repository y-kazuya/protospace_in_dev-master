class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :tag_prototypes , dependent: :destroy
  has_many :tags, through: :tag_prototypes
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images
  accepts_nested_attributes_for :tags ,reject_if: :reject_tags_blank && :reject_tags_duplicate,limit: 3
  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
  def reject_tags_blank(attributed)
    attributed['name'].blank?
  end
  def reject_tags_duplicate(attributed)
    Tag.exists?(name:attributed['name'])
  end

end
