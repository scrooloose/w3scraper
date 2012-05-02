#!/usr/bin/env ruby

require 'nokogiri'
require 'date'
require 'optparse'


class W3scraper
  VERSION = '0.0.1'

  def initialize(arguments, stdin)
    @arguments = arguments
    @stdin = stdin
    @options = {}
    parse_options
  end

  def run
    errors = parse_errors(w3_parser_output)
    print_errors(errors)
  end

  protected

    def w3_parser_output
      @w3_parser_output ||= `curl -s -F output=text -F "uploaded_file=@#{@target_file};type=text/html" http://validator.w3.org/check`
    end

    def print_errors(errors)
      errors.each do |result|
        puts "Line #{result[:line]} Col #{result[:col]}: #{result[:msg]}"
      end
    end

    def parse_errors(output)
      doc = Nokogiri::HTML(output)
      ret_val = []

      doc.css("#error_loop .msg_err").each do |e|
        next_result = {}

        #extract line/column numbers
        pos_match = e.css("em").first.to_s.match(/Line (\d*).*Column (\d*)/m)
        next_result[:line] = pos_match[1]
        next_result[:col] = pos_match[2]

        #extract error message
        next_result[:msg] = e.css(".msg").first.content

        ret_val << next_result
      end

      ret_val
    end


    def parse_options
      opts = OptionParser.new
      opts.banner = "Usage: #{File.basename(__FILE__)} [options] [file to validate]"

      opts.on('-v', '--version') do
        puts "version: #{VERSION}"
        exit 0
      end

      opts.on('-h', '--help') do
        puts opts
        exit 0
      end

      opts.parse!(@arguments)

      if @arguments.size != 1
        puts opts
        exit 1
      end

      @target_file = @arguments.first
    end
end
