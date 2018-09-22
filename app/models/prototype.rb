class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images
  accepts_nested_attributes_for :tags ,reject_if: :reject_tags_blank 
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
  # after_create do
  #   prototype = Prototype.find_by(id:self.id)
  #   binding.pry
  #   #ここにどうやってフォームのタグのデータもってくるかだ
  #   #sometags = self.class.scan("tag")
  #   #sometags.uniq.map do |onetag|
  #   tag = Tag.find_or_create_by(name: onetag)
  #   prototype.tags << tag
  #   #end
  # end

  # before_update do
  #   prototype = Prototype.find_by(id: self.id)
  #   prototype.tags.clear
  #   sometags = self.class.scan("tag")
  #   sometags.uniq.map do |onetag|
  #     tag = Tag.find_or_create_by(name: onetag)
  #     prototype.tags << tag
  #   end
  # end

end
