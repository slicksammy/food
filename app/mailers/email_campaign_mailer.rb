class EmailCampaignMailer < ActionMailer::Base

  default from: 'iheartmeat <support@iheartmeat.com>'

  layout 'bootstrap'

  def email_campaign(template, params, time_since_last_email=nil)
    return if time_since_last_email && EmailLog.email_in_the_last_hours(params[:to], time_since_last_email).any?

    @params = params

    mail(to: params[:to], subject: params[:subject], bcc: params[:bcc], template_name: template)
  end
end
