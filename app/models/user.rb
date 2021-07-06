class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image
  
  validates :username, presence: true
  
  has_many :recipes, :dependent => :destroy
  has_many :posts
  
  
  # 自分がフォローしているユーザーを参照
  has_many :relationships
  # ユーザーからフォローされている参照
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  
  # relationships　を経由してフォローフォロワーをとることでuser.followingsとしてとってこれる
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    # 対象が自分自身でなければフォロー可能　selfは呼び出したユーザー
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    # すでにフォローしているか確認　selfは呼び出したユーザー selfはrelationshipテーブルにfollow_idがother_user_idのものを持っているか
    relationship = self.relationships.find_by(follow_id: other_user.id)
    # フォローしていればフォロー解除可能
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
    def self.search(search)
        return User.all unless search
        User.where('username LIKE ?', "%#{search}%")
    end
  
end
