# simplistic Mock object for Spread
class Spread
class Mock
    attr_accessor :dir, :position, :failempty

    def initialize(dir)
        @dir = dir
        @position = 0
        @messages = []
        Dir.open(dir).sort.each { |x|
            if x =~ /^spdm-(\d+)-(.*?)-(.*)/ then # TODO timings
                message = File.open("#{dir}/#{x}").read
                @messages.push Spread::DataMessage.new( [$3], "#"+$2, message )
            end
        }
    end

    def poll
        if @messages.size == 0 and @failempty then
            exit
        end
        return @messages.size > 0
    end

    def receive
        return @messages.shift
    end
end

class DataMessage
    attr_accessor :groups, :sender, :message
    def initialize(groups, sender, message)
        @groups = groups
        @sender = sender
        @message = message
    end
end

end
