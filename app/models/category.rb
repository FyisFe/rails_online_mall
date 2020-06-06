class Category < ApplicationRecord


    validates :title, presence: { message: "You must input a name!" }
    validates :title, uniqueness: { message: "You must input an unique name!" }


    has_ancestry orphan_strategy: :destroy

    has_many :products, dependent: :destroy

    before_validation :correct_ancestry

    private
    def correct_ancestry
        self.ancestry = nil if self.ancestry.blank?
    end

end
