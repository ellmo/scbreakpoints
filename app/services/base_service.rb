# frozen_string_literal: true

class BaseService < PiperService

  def initialize(_)
    raise NotImplementedError unless self.class < BaseService

    super
  end

end
