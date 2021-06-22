module Slug
    extend ActiveSupport::Concern

    def self.slug_generator(field)
        field.to_s.parameterize
    end
end