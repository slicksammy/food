class EmailCampaignMailerPreview < ActionMailer::Preview

  def email_campaign
    EmailCampaignMailer.email_campaign('november_26', { name: 'sam', to: 'sam@iheartmeat.com', subject: 'iheartmeat - skip the grocery store lines'})
  end
end
