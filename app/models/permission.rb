class Permission < ApplicationRecord
  belongs_to :user
  validates_presence_of :accept
end
