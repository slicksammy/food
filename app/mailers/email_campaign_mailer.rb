class EmailCampaignMailer < ActionMailer::Base

  default from: 'iheartmeat <support@iheartmeat.com>'

  layout 'bootstrap'

  def email_campaign(template, params)
    @params = params

    mail(to: params[:to], subject: params[:subject], bcc: params[:bcc], template_name: template)
  end
end
