class OrderMailerPreview < ActionMailer::Preview
  def place_order
    OrderMailer.place_order
  end

  def delivered
    OrderMailer.delivered(Order.last, note: 'this is the note, cheers!')
  end

  def continue_order
    OrderMailer.continue_order(Order.ongoing.first)
  end
end
