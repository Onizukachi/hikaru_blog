# frozen_string_literal: true

class ViewChannel < Turbo::StreamsChannel
  def subscribed
    super
  end
end
