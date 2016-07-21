# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user
    to ["my-pushcart-address@#{EMAIL_URI}"]
    from 'notices@some_grocery_email.com'
    subject 'email subject'
    raw_html ''
    raw_text ''

    trait :set_mission do
      to "set_your_mission@#{SITE_URL}"
      from 'michael.carroll@cornell.edu'
      subject 'Re: Set your household mission!'
      raw_html File.read('./pushcart_sample_emails/missions/set_mission_example.eml')
    end

    ### Grocery service e-mails ###

    trait :fresh_direct_receipt_one do
      from 'receipt@freshdirect.com'
      subject 'Your order for Sunday, Jan 26 2014'
      raw_html File.read('./pushcart_sample_emails/fresh_direct/receipt_one.eml')
      raw_text File.read('./pushcart_sample_emails/fresh_direct/receipt_one.eml')
    end

    trait :fresh_direct_receipt_two do
      from 'receipt@freshdirect.com'
      subject 'Your order for Sunday, Jan 26 2014'
      raw_html File.read('./pushcart_sample_emails/fresh_direct/receipt_two.eml')
      raw_text File.read('./pushcart_sample_emails/fresh_direct/receipt_two.eml')
    end

    trait :instacart_receipt do
      from 'orders@instacart.com'
      subject 'Fwd: Your Order with Instacart'
      raw_html File.read('./pushcart_sample_emails/instacart/instacart_receipt.eml')
    end

    trait :peapod_receipt_one do
      from 'yourfriends@peapod.com'
      subject 'Peapod by Stop & Shop Order Confirmation j50570360'
      raw_html File.read('./pushcart_sample_emails/peapod/receipt_one.eml')
    end

    trait :peapod_receipt_two do
      from 'yourfriends@peapod.com'
      subject 'Fwd: Peapod by Stop & Shop Order Confirmation j49123888'
      raw_html File.read('./pushcart_sample_emails/peapod/receipt_two.eml')
    end

    trait :peapod_receipt_three do
      from 'yourfriends@peapod.com'
      subject 'Re: Peapod by Stop & Shop Order Confirmation j48340159'
      raw_html File.read('./pushcart_sample_emails/peapod/receipt_three.eml')
    end

  end
end
