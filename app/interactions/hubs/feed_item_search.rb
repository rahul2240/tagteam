# frozen_string_literal: true

module Hubs
  # Search from FeedItems
  class FeedItemSearch < ActiveInteraction::Base
    object :hub
    integer :per_page
    hash :params

    def execute
      FeedItem.search do
        with :hub_ids, hub.id
        paginate page: params[:page], per_page: per_page
        order_by(:date_published, :desc)
        if params[:q].present?
          fulltext params[:q]
          adjust_solr_params do |params|
            params[:q].gsub '#', "tag_contexts_sm:#{hub.tagging_key}-"
          end
        end
      end
    end
  end
end
