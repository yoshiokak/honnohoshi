# frozen_string_literal: true

class Service
  def self.search(isbn)
    services = []

    service_list.each do |service_name|
      services << Object.const_get(service_name).new(isbn)
    end

    services
  end

  def self.service_list
    [
      "RakutenBooks",
      "Bookmeter"
    ]
  end

  private_class_method :service_list
end
