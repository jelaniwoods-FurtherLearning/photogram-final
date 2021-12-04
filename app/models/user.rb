# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  photos_count    :integer
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password


  has_many(:photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy })
  has_many(:comments, { :class_name => "Comment", :foreign_key => "author_id", :dependent => :destroy })
 # has_many(:followrers, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })
 # has_many(:followings, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })

 def sent_follow_requests
  my_id = self.id

  matching_follow_requests = FollowRequest.where({ :sender_id => my_id })

  return matching_follow_requests
end

def received_follow_requests
  my_id = self.id

  matching_follow_requests = FollowRequest.where({ :recipient_id => my_id })

  return matching_follow_requests
end

def accepted_sent_follow_requests
  my_sent_follow_requests = self.sent_follow_requests

  matching_follow_requests = my_sent_follow_requests.where({ :status => "accepted" })

  return matching_follow_requests
end

def accepted_received_follow_requests
  my_received_follow_requests = self.received_follow_requests

  matching_follow_requests = my_received_follow_requests.where({ :status => "accepted" })

  return matching_follow_requests
end


def pending_received_follow_requests
  my_received_follow_requests = self.received_follow_requests

  matching_follow_requests = my_received_follow_requests.where({ :status => "pending" })

  return matching_follow_requests
end

def fssss
  my_pending_received_follow_requests = self.pending_received_follow_requests
  
  array_of_user_ids = Array.new

  my_pending_received_follow_requests.each do |a_follow_request|
    array_of_user_ids.push(a_follow_request.sender_id)
  end

  matching_users = User.where({ :id => array_of_user_ids })

  return matching_users
end

 def followers
  my_accepted_received_follow_requests = self.accepted_received_follow_requests
  
  array_of_user_ids = Array.new

  my_accepted_received_follow_requests.each do |a_follow_request|
    array_of_user_ids.push(a_follow_request.sender_id)
  end

  matching_users = User.where({ :id => array_of_user_ids })

  return matching_users
end

def leaders
  my_accepted_sent_follow_requests = self.accepted_sent_follow_requests
  
  array_of_user_ids = Array.new

  my_accepted_sent_follow_requests.each do |a_follow_request|
    array_of_user_ids.push(a_follow_request.recipient_id)
  end

  matching_users = User.where({ :id => array_of_user_ids })

  return matching_users
end

def feed
  array_of_photo_ids = Array.new

  my_leaders = self.leaders
  
  my_leaders.each do |a_user|
    leader_own_photos = a_user.photos

    leader_own_photos.each do |a_photo|
      array_of_photo_ids.push(a_photo.id)
    end
  end

  matching_photos = Photo.where({ :id => array_of_photo_ids })

  return matching_photos
end


  validates(:username, { :presence => true })
  validates(:username, { :uniqueness => true })

end
