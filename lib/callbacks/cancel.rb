module Bot
  module Callback
    class Cancel < Base # :nodoc:
      def should_start?
        data.first =~ %r{cancel}
      end

      def start
        edit_message(callback_response("confirmation"))
      end
    end
  end
end
