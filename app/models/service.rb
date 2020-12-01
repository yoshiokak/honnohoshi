# frozen_string_literal: true

class Service
  def self.search(isbn)
    services = []

    service_list.each do |service_name|
      services << Object.const_get(service_name).new
    end

    Parallel.each(services, in_threads: services.size) do |service|
      service.search(isbn)
    end

    services
  end

  def self.service_list
    [
      "Amazon",
      "RakutenBooks",
      "Bookmeter",
      "Hongasuki"
    ]
  end

  private_class_method :service_list
end
