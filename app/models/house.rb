class House < ApplicationRecord
  after_create :notify

  def notify
    res = RestClient.get("https://api.telegram.org/bot1663701169:AAFqxodJvqbbxbRhcynoCU9LAZLgYllOQ1M/sendMessage?chat_id=297054768&text='#{self.url}'")
  end
end
