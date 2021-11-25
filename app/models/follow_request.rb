# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord

  belongs_to(:recipient, { :required => true, :class_name => "User", :foreign_key => "recipient_id" })
  validates(:status, { :presence => true })
  validates(:recipient_id, { :presence => true })
end
