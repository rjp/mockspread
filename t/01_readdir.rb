require 'test/unit'
require 'rubygems'
require 'mockspread'

class Test_PQueue < Test::Unit::TestCase
    attr_accessor :tq

    def test_nofiles
        @tq = Spread::Mock.new('t/nomessages')
    end

    def test_files
        @tq = Spread::Mock.new('t/onemessage')
    end

    def test_poll
        @tq = Spread::Mock.new('t/onemessage')
        assert_equal(@tq.poll, true, 'one pending message')
    end

    def test_receive
        @tq = Spread::Mock.new('t/onemessage')
        if @tq.poll then
            rm = @tq.receive
            assert_equal(rm.class, Spread::DataMessage, 'class')
            assert_equal(rm.groups.size, 1, 'one group')
            assert_equal(rm.groups[0], 'sport_json', 'sports group')
            assert_equal(rm.sender, '#cricinfo', 'cricinfo')
        end
    end

    def test_receive_N_from_one
        @tq = Spread::Mock.new('t/onemessage')
        counter = 0
        while @tq.poll do
            rm = @tq.receive
            assert_equal(rm.class, Spread::DataMessage, 'class')
            counter = counter + 1
        end
        assert_equal(counter, 1, 'only one message')
    end

    def test_receive_two_from_two
        @tq = Spread::Mock.new('t/twomessages')
        counter = 0
        while @tq.poll do
            rm = @tq.receive
            assert_equal(rm.class, Spread::DataMessage, 'class')
            counter = counter + 1
        end
        assert_equal(counter, 2, 'two messages')
    end
end
