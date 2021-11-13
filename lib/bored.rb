# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'bored/version'
require_relative 'bored/cli'

module Bored
  class Error < StandardError
  end

  Activity =
    Struct.new(
      :id,
      :description,
      :type,
      :participants,
      :accessibility,
      :price,
      :link,
      keyword_init: true
    )

  def self.now(arg = '')
    json = JSON.parse(Net::HTTP.get('www.boredapi.com', "/api/activity#{arg}"))
    if json['error']
      'No activity found with the specified parameters'
    else
      Activity.new(
        id: json['key'].to_i,
        description: json['activity'],
        type: json['type'].to_sym,
        participants: json['participants'],
        accessibility: json['accessibility'],
        price: json['price'],
        link: json['link'].empty? ? nil : json['link']
      )
    end
  end

  def self.find(id)
    url_extension = "?key=#{id}"
    now(url_extension)
  end

  def self.find_by_price(price)
    url_extension = "?price=#{price}"
    now(url_extension)
  end

  def self.find_by_accessibility(num)
    url_extension = "?accessibility=#{num}"
    now(url_extension)
  end

  def self.a_range(min, max)
    url_extension = "?minprice=#{min}&maxprice=#{max}"
    now(url_extension)
  end

  def self.price_range(min, max)
    url_extension = "?minaccessibility=#{min}&maxaccessibility=#{max}"
    now(url_extension)
  end

  def self.type(type)
    url_extension = "?type=#{type}"
    now(url_extension)
  end

  def self.participants(num)
    url_extension = "?participants=#{num}"
    now(url_extension)
  end
end
