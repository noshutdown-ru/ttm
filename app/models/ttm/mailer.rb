#require_dependency "#{Rails.root}/app/models/mailer"

class TTM::Mailer < Mailer
  def notify(address, subscription)
    @subscription = subscription
    mail to: address, subject: t('ttm.notifications.mail_subject')
  end
end
