# frozen_string_literal: true

module TransactionType
  class BaseService
    def initialize(args = {})
      @args = args
    end

    def create
      raise NotImplementedError
    end

    protected

    attr_reader :args
  end
end
