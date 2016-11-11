require "date"
require "ohm/datatypes"

module Bot
  class Notification < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :status,    Type::Boolean
    attribute :weekday,   Type::Integer
    attribute :period,    Type::Integer

    # last_sent always contain date
    attribute :last_sent, Type::Date

    reference :user, "Bot::User"

    def can_notify?
      status && last_sent != Date.today_utc && (on_weekday? || on_daily?)
    end

    def on_weekday?
      Date.today_utc.cwday == weekday
    end

    def on_daily?
      (Date.today_utc - last_sent).round >= period if last_sent
    end

    def update_timestamp
      update(last_sent: Date.today_utc)
    end
  end
end
