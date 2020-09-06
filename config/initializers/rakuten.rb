# frozen_string_literal: true

RakutenWebService.configure do |c|
  c.application_id = ENV["RAKUTEN_APP_ID"]
  c.affiliate_id = ENV["RAKUTEN_AFFILIATE_ID"]
end
