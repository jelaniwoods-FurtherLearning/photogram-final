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

  def sender
    my_sender_id = self.sender_id

    matching_users = User.where({ :id => my_sender_id })

    the_user = matching_users.at(0)

    return the_user
  end

  def recipient
    my_recipient_id = self.recipient_id

    matching_users = User.where({ :id => my_recipient_id })

    the_user = matching_users.at(0)

    return the_user
  end
  #validates(:status, { :presence => true })
 # validates(:recipient_id, { :presence => true })
end
