class User < ApplicationRecord
  # Direct associations

  has_many   :received_follow_requests,
             :class_name => "FollowRequest",
             :foreign_key => "recipient_id",
             :dependent => :destroy

  has_many   :sent_follow_requests,
             :class_name => "FollowRequest",
             :foreign_key => "sender_id",
             :dependent => :destroy

  has_many   :likes,
             :dependent => :destroy

  has_many   :uploads,
             :class_name => "Photo",
             :dependent => :destroy

  # Indirect associations

  has_many   :timeline,
             :through => :leaders,
             :source => :uploads

  has_many   :followers,
             :through => :received_follow_requests,
             :source => :sender

  has_many   :leaders,
             :through => :sent_follow_requests,
             :source => :recipient

  has_many   :favorites,
             :through => :likes,
             :source => :photo

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
