class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "fishmilk0313@yahoo.co.jp", subject: "confirmation"
  end
end
