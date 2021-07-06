class Recipe < ApplicationRecord
    belongs_to :user
    has_many :posts
    attachment :image
    
    validates :title, presence: true
    validates :body, presence: true
    validates :base, presence: true
    validates :technique, presence: true
  
    enum base: {gin:0, rum:1, vodka:2, tequila:3, bourbon:4, scotch:5, rye:6, brandy:7, mezcal:8,liqueur:8,other:9}
    enum technique: { building:0, stiring:1, shaken:2, blending:3 ,other_way:4}
    
    def self.search(search)
        return Recipe.all unless search
        Recipe.where('title LIKE(?)', "%#{search}%")
        
    end
    
    
    mount_uploader :image, ImageUploader
end
