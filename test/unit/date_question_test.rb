# coding:utf-8

require_relative '../test_helper'
require 'ostruct'

module SmartAnswer
  class DateQuestionTest < ActiveSupport::TestCase
    def setup
      @initial_state = State.new(:example)
    end
  
    test "Dates are parsed from hash form before being saved" do
      q = Question::Date.new(:example) do
        save_input_as :date
        next_node :done
      end
    
      new_state = q.transition(@initial_state, {year: "2011", month: '2', day: '1'})
      assert_equal '2011-02-01', new_state.date
    end

    test "Can define allowable range of dates" do
      q = Question::Date.new(:example) do
        save_input_as :date
        next_node :done
        from { Date.parse('2011-01-01') }
        to { Date.parse('2011-01-03') }
      end
      assert_equal ::Date.parse('2011-01-01')..::Date.parse('2011-01-03'), q.range
    end
  end
end