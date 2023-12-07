# frozen_string_literal: true

module Vieweable
  extend ActiveSupport::Concern

  included do
    private

    def mark_view(vieweable)
      vieweable.increment!(:views_count)

      Turbo::StreamsChannel.broadcast_replace_to(
        helpers.dom_id(vieweable, 'views_count'),
        target: helpers.dom_id(vieweable, 'views_count'),
        partial: 'shared/views_count', locals: { vieweable: }
      )
    end
  end
end
