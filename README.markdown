# mockspread

mockspread gives you a mock Spread client you can feed with predetermined messages.

    if ENV['MOCK_SPREAD'] then # read our predetermined list
        require 'mockspread'
        sp = Spread::Mock.new(ENV['MOCK_SPREAD'])
        sp.failempty = true # abort when we run out of messages
    else # connect to the spread daemon
        require 'spread.so'
        sp = Spread::Connection.new("4803", spreadname)
        sp.join('send_me_stuff')
    end

## Filename convention

Message files match the pattern `spdm-(\d+)-(.*?)-(.+)`

* spdm - Spread Data Message
* \d+  - Index of this message (used for ordering)
* .*?  - Sender name (will be prefixed with #)
* .+   - Group name

The contents of the file will be used as the message content.
