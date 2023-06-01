class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true

    def self.random_code
        check = true
        while check
            temp = SecureRandom.urlsafe_base64
            check = self.exists?(:short_url => temp)
        end
        temp
    end

    after_initialize do |url|
        generate_short_url if url.new_record?
    end

    belongs_to :submitter,
               class_name: 'User',
               foreign_key:'user_id',
               primary_key: 'id'

    private
    def generate_short_url
        if !self.short_url
            self.short_url = ShortenedUrl.random_code
        end
    end
end