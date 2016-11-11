require "ohm/datatypes"

module Bot
  class User < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :telegram_id
    attribute :first_name
    attribute :last_name

    attribute :all_submited, Type::Boolean

    reference :semester,     "Bot::Semester"
    reference :next_command, "Bot::NextCommand"
    reference :callback,     "Bot::CallbackContainer"
    reference :notification, "Bot::Notification"
    set       :subjects,     "Bot::Subject"

    index     :telegram_id
    unique    :telegram_id

    def subjects_present?
      subjects && subjects.size.positive?
    end

    def subject_exist?(name)
      subjects.find(name: name).size.positive?
    end

    def self.find_or_create_by(id, from)
      user = User.find(telegram_id: id).first
      user || User.create(
        telegram_id:  id,
        first_name:   from.first_name,
        last_name:    from.last_name,
        semester:     Bot::Semester.create,
        next_command: Bot::NextCommand.create,
        callback:     Bot::CallbackContainer.create,
        notification: Bot::Notification.create
      )
    end
  end
end
