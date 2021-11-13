# frozen_string_literal: true

require 'test_helper'

class TestBored < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bored::VERSION
  end

  def test_that_it_gives_you_an_activity
    activity = Bored.now

    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_find_success
    sid = 5_881_028
    url_extension = "?key=#{sid}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_find_failed
    fid = '5d81a28'
    url_extension = "?key=#{fid}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_price_success
    price = 0.5
    url_extension = "?price=#{price}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_price_fail_over
    price = 100
    url_extension = "?price=#{price}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_price_fail_negative_value
    price = -100
    url_extension = "?price=#{price}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_price_fail_not_numeric
    price = 'aaad'
    url_extension = "?price=#{price}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_find_by_accessibility_success
    num = 0.5
    url_extension = "?accessibility=#{num}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_a_range_success
    min = 0.0
    max = 0.5
    url_extension = "?minprice=#{min}&maxprice=#{max}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_price_range_success
    min = 0.0
    max = 0.5
    url_extension = "?minaccessibility=#{min}&maxaccessibility=#{max}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_type_success
    type = 'education'
    url_extension = "?type=#{type}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert activity.type == :education
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_type_fail_not_a_type
    type = 'educatnal'
    url_extension = "?price=#{type}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_participants_success
    num = 8
    url_extension = "?participants=#{num}"
    activity = Bored.now(url_extension)
    assert_kind_of Numeric, activity.id
    assert_kind_of String, activity.description
    assert_includes(
      %i[
        education
        recreational
        social
        diy
        charity
        cooking
        relaxation
        music
        busywork
      ],
      activity.type
    )
    assert_kind_of Integer, activity.participants
    assert (0..1).cover?(activity.accessibility)
    assert (0..1).cover?(activity.price)
    assert [String, NilClass].include?(activity.link.class)
  end

  def test_participants_fail_over
    num = 100
    url_extension = "?participants=#{num}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_participants_fail_negative_value
    num = -100
    url_extension = "?participants=#{num}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end

  def test_participants_fail_not_numeric
    num = 'dfsa'
    url_extension = "?participants=#{num}"
    failed = Bored.now(url_extension)
    assert failed == 'No activity found with the specified parameters'
  end
end
