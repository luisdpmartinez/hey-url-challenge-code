# frozen_string_literal: true

class Url < ApplicationRecord
  require 'securerandom'
  validates :short_url, uniqueness: true
  before_validation :set_short_url
  has_many :clicks

  def set_short_url
    if self.short_url.nil?
      self.short_url = SecureRandom.send(:choose, [*'A'..'Z'], 5)
    end
  end

end
