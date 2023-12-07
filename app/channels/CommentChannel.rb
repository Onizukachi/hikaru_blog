# frozen_string_literal: true

class CommentChannel < Turbo::StreamsChannel
  def subscribed
    super
  end
end
