module Bot
  module Callback
    class Base # :nodoc:
      include Bot::TranslationHelpers

      attr_reader :user,
                  :api,
                  :data,
                  :message

      def initialize(api, user, query)
        @data    = query.data.split(";")
        @message = query.message
        @user    = user
        @api     = api
      end

      def should_start?
        fail(NotImplementedError)
      end

      def start
        fail(NotImplementedError)
      end

      protected

      def verify_callback
        check = user.callback.message_id == message.message_id
        fail(BotError, "callback_invalid_message") unless check
      end

      def edit_message(text, options = {})
        options[:chat_id] = user.telegram_id
        options[:message_id] = message.message_id
        options[:text] = text
        api.call("editMessageText", options)
      end
    end
  end
end
