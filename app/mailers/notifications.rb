class Notifications < ActionMailer::Base
  default from: "team@storifypenn.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_contract.subject
  #
  def new_contract(contract)
    @greeting = "Dear " + contract.seller_name
    @buyer_name = contract.buyer_name
    @buyer_first_name = contract.buyer.first_name
    @begin = contract.begin
    @end = contract.end
    @rate = contract.rate
    @buyer_email = contract.buyer.email
    #@contract = contract
    mail to: contract.seller.email
  end
end
