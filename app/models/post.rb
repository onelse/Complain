class Post < ApplicationRecord
  acts_as_votable
  resourcify
  belongs_to :user
  
  #조회수 기능
  
end
