# frozen_string_literal: true

require "parallel"

class Service
  def self.search(isbn)
    services = []

    service_list.each do |service_name|
      services << Object.const_get(service_name).new(isbn)
    end

    Parallel.each(services, in_threads: service_list.size) do |service|
      service.fetch
    end

    services
  end

  def self.service_list
    [
      "RakutenBooks",
      "Bookmeter",
      "Hongasuki"
    ]
  end

  private_class_method :service_list
end
