class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  belongs_to :prefecture, optional: true

  has_many :sweets, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_sweets, through: :favorites, source: :sweet, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :went_sweets, through: :wents, source: :sweet
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def favorite(sweet)
      self.favorites.find_or_create_by(sweet_id: sweet.id)
  end

  def unfavorite(sweet)
    favorite = self.favorites.find_by(sweet_id: sweet.id)
    favorite.destroy if favorite
  end
  
  def favorite?(sweet)
    favorite_sweets.include?(sweet)
  end
  
  def went(sweet)
      self.wents.find_or_create_by(sweet_id: sweet.id)
  end

  def unwent(sweet)
    went = self.wents.find_by(sweet_id: sweet.id)
    went.destroy if went
  end
  
  def went?(sweet)
    went_sweets.include?(sweet)
  end
  
  def feed_sweets
    Sweet.where(user_id: self.following_ids + [self.id])
  end
  
  def feed_favorites
    Sweet.where(id: favorite_sweets)
  end
  
  def feed_wents
    Sweet.where(id: went_sweets)
  end
end