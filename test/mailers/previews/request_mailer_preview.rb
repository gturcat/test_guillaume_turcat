# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/confirmation
  def confirmation
    request = Request.first
    # This is how you pass value to params[:user] inside mailer definition!
    RequestMailer.with(request: request).confirmation
  end

end
