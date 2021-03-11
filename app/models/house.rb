class House < ApplicationRecord
  after_create :notify

  def notify
    minutes_from_now = ((DateTime.now - self.publish_date.to_datetime) * 24 * 60).to_i
    if minutes_from_now <= 60
      RestClient.get("https://api.telegram.org/bot1663701169:AAFqxodJvqbbxbRhcynoCU9LAZLgYllOQ1M/sendMessage?chat_id=297054768&text=Precio%3A%20#{self.price}%0ADormitorios%3A%20#{self.rooms}%2C%0AURL%3A%20#{self.url}")
    end
  end
end
