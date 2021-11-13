# frozen_string_literal: true

require 'pry'
require 'optparse'

module Bored
  class Cli
    attr_accessor :argv

    def initialize(argv)
      @argv = argv
    end

    def is_numeric?(i)
      i == i.to_i.to_s || i == i.to_f.to_s
    end

    def run
      opt_parser =
        OptionParser.new do |opts|
          opts.banner = 'Availible Flags for Bored CLI'

          opts.on(
            '-aNUMBER',
            '--accessiblity=NUMBER',
            'Get random activity by Accessiblity. 0.0..0.8'
          ) do |num|
            if is_numeric?(num)
              pp Bored.find_by_accessibility(num)
            else
              puts 'Accessiblity must be a number between 0.0..0.8'
            end
          end

          opts.on(
            '-cNUMBER',
            '--price=NUMBER',
            'Get random activity by Price. 0.0..0.8'
          ) do |price|
            if is_numeric?(price)
              pp Bored.find_by_price(price)
            else
              puts 'Price must be a number between 0.0..0.8'
            end
          end

          opts.on('-iID', '--id=ID', 'Search for activity by ID') do |id|
            if is_numeric?(id)
              pp Bored.find(id)
            else
              puts 'ID must be a number.'
            end
          end

          opts.on('-r', '--random', 'Get random activity') do |_id|
            pp Bored.now.description
          end

          opts.on(
            '-tTYPE',
            '--type=TYPE',
            "Find a random activity with a given type: \n'education', 'recreational', 'social', 'diy', 'charity', 'cooking', 'relaxation', 'music', 'busywork'"
          ) do |type|
            allowed = %w[
              education
              recreational
              social
              diy
              charity
              cooking
              relaxation
              music
              busywork
            ]
            if allowed.include?(type)
              pp Bored.type(type)
            else
              puts "Has to be one of the following types: 'education', 'recreational', 'social', 'diy', 'charity', 'cooking', 'relaxation', 'music', 'busywork'"
            end
          end

          opts.on(
            '--a-range 0.0,1.0',
            Array,
            'Find an event with a specified accessibility range'
          ) do |mm|
            guard = mm.map { |i| is_numeric?(i) }
            if !guard.include?(false) && guard.length > 1
              pp Bored.a_range(mm[0], mm[1])
            else
              puts 'Range must have atleast two Numeric arguments'
            end
          end

          opts.on(
            '--price-range 0.0,1.0',
            Array,
            'Find an event with a specified price in an inclusively constrained range'
          ) do |price_range|
            guard = price_range.map { |i| is_numeric?(i) }
            if !guard.include?(false) && guard.length > 1
              pp Bored.price_range(price_range[0], price_range[1])
            else
              puts 'Range must have atleast two Numeric arguments'
            end
          end

          opts.on(
            '-pNUMBER',
            '--participants=NUMBER',
            'Find a random activity with a given number of participants'
          ) do |participants|
            if is_numeric?(participants) && participants.to_i <= 8
              pp Bored.participants(participants)
            else
              puts 'participants has to be a number no larger than 8'
            end
          end

          opts.on('-h', '--help', 'Prints this help') do
            puts opts
            exit
          end
        end

      @argv << '-r' if @argv.empty?
      opt_parser.parse!(@argv)
    end
  end
end
