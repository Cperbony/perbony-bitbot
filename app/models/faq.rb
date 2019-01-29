# Frequenty Asked Questions Class
# One Faq has many hashtags
class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer

  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
end