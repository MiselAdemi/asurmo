class SearchSuggestion < ApplicationRecord
  def self.terms_for(prefix, organization_id)
    suggestions = where("term like ?", "#{prefix}_%")
    suggestions.order("popularity desc").limit(10).pluck(:term)
  end

  def self.index_users
    User.find_each do |user|
      #if(!user.is_organization_admin?(organization))
        index_term(user.email)
    end
  end

  def self.index_term(term)
    where(term: term.downcase).first_or_initialize.tap do |suggestion|
      suggestion.increment! :popularity
    end
  end
end
