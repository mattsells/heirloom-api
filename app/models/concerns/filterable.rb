# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def sift(filtering_params)
      results = where(nil)

      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end

      results
    end

    def extended_includes(params, *includes)
      results = where(nil)

      is_extended = ActiveModel::Type::Boolean.new.cast(params[:extended])

      if is_extended
        includes.each do |association|
          results.includes(association)
        end
      end

      results
    end

    # TODO: Add tests for this
    def paginate(params)
      results = where(nil)

      count = results.count

      page = params[:page] || 1
      per = params[:per] || 20
      offset = (page - 1) * per

      results = results.offset(offset).limit(per)

      next_page = page * per < count ? page + 1 : nil

      meta = {
        total: count,
        current_page: page,
        next_page: next_page
      }

      [results, meta]
    end
  end
end
