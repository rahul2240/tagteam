# frozen_string_literal: true

module Hubs
  # creates hub
  class Create < ActiveInteraction::Base
    object :hub
    object :user
    hash :hub_attributes

    def execute
      hub.attributes = hub_attributes
      return unless hub.save

      user.has_role!(:owner, @hub)
      user.has_role!(:creator, @hub)
    end
  end
end
