class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "fishmilk0313@gmail.com", subject: "confirmation"
  end
end
