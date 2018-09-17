class Tag < ActiveRecord::Base
  has_many :tag_prototypes
  has_many :prototypes ,through: :tag_prototypes
end
