FactoryGirl.define do
  factory :email, class: OpenStruct do
    to ["my-pushcart-address@#{EMAIL_URI}"]
    from 'notices@some_grocery_email.com'
    subject 'email subject'
    body 'Hello!'
    attachments {[]}

    trait :fresh_direct_receipt_one do
      from 'receipt@freshdirect.com'
      subject 'Your order for Sunday, Jan 26 2014'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')
    end

    trait :fresh_direct_receipt_two do
      from 'receipt@freshdirect.com'
      subject 'Your order for Sunday, Jan 26 2014'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_two.eml')
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_two.eml')
    end

    trait :fresh_direct_receipt_three do
      from 'receipt@freshdirect.com'
      subject 'Your order for Sunday, Aug 3 2014'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_three.eml')
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_three.eml')
    end

    trait :fresh_direct_receipt_four do
      from 'receipt@freshdirect.com'
      subject 'Fwd: Your order for Tuesday, Aug 5 2014'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_four.eml')
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_four.eml')
    end

    trait :fresh_direct_auto_forward_receipt_one do
      from 'receipt@freshdirect.com'
      subject 'Fwd: Your order for Sunday, Aug 17 2014'
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/gmail_autoforward_receipt.eml')
    end

    trait :instacart_receipt do
      from 'orders@instacart.com'
      subject 'Fwd: Your Order with Instacart'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/instacart/instacart_receipt.eml')
    end

    trait :peapod_receipt_one do
      from 'yourfriends@peapod.com'
      subject 'Peapod by Stop & Shop Order Confirmation j50570360'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/peapod/receipt_one.eml')
    end

    trait :peapod_receipt_two do
      from 'yourfriends@peapod.com'
      subject 'Fwd: Peapod by Stop & Shop Order Confirmation j49123888'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/peapod/receipt_two.eml')
    end

    trait :peapod_receipt_three do
      from 'yourfriends@peapod.com'
      subject 'Fwd: Peapod by Stop & Shop Order Confirmation j48340159'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/peapod/receipt_three.eml')
    end

    trait :seamless_receipt_one do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Il Porto received your order. Estimated Delivery: 45 - 60 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_one.eml')
    end

    trait :seamless_receipt_two do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Chaska Fine Indian Cuisine received your order.'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_two.eml')
    end

    trait :seamless_receipt_three do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Shinju III received your order. Estimated Delivery: 30 - 45 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_three.eml')
    end

    trait :seamless_receipt_four do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Fusion Sushi (brought to you by Chef 28) received your order. Estimated Delivery: 25 - 40 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_four_html.html')
    end

    trait :seamless_receipt_five do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Saigon Market received your order. Estimated Delivery: 30 - 45 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_five.eml')
    end

    trait :seamless_receipt_six do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Mamagyro (Broadway) received your order. Estimated Delivery: 30 - 45 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_six.eml')
    end

    trait :seamless_receipt_seven do
      from 'confirmation@seamless.com'
      subject 'Confirmed! Amber (West Village) received your order. Estimated Delivery: 30 - 45 minutes'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/seamless/receipt_seven.eml')
    end

    trait :grubhub_receipt_one do
      from 'order@grubhub.com'
      subject 'Your Order from Jellyfish is in the Works'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/grubhub/receipt_one.eml')
    end

    trait :grubhub_receipt_two do
      from 'order@grubhub.com'
      subject 'Your Order from Kodama Sushi is in the Works'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/grubhub/receipt_two.eml')
    end

    trait :grubhub_receipt_three do
      from 'order@grubhub.com'
      subject 'Your Order from Taste of Thai Express is in the Works'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/grubhub/receipt_three_html.html')
    end

    trait :grubhub_receipt_four do
      from 'orders@grubhub.com'
      subject 'Your Order from Tiengarden Vegan Kitchen is in the Works'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/grubhub/receipt_four_html.html')
    end

    trait :caviar_receipt_one do
      from 'nycsupport@trycaviar.com'
      subject "Your Caviar Order from Mighty Quinn's Barbeque for delivery on February 3rd"
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/caviar/receipt_one.eml')
    end

    trait :caviar_receipt_two do
      from 'nycsupport@trycaviar.com'
      subject "Your Caviar Order from Otto's Tacos for delivery on February 4th"
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/caviar/receipt_two.eml')
    end

    trait :gmail_autoforwarder_one do
      from 'forwarding-noreply@google.com'
      subject '(#247446234) Gmail Forwarding Confirmation - Receive Mail from alexia.white@gmail.com'
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/gmailers/autoforwarder_one.eml')
    end

    trait :gmail_autoforwarder_two do
      from 'forwarding-noreply@google.com'
      subject '(#867308695) Gmail Forwarding Confirmation - Receive Mail from lopez.juanr@gmail.com'
      raw_text File.read(Rails.root.to_s + '/lib/sample_emails/gmailers/autoforwarder_two.eml')
    end

    trait :set_mission do
      to "set_your_mission@#{SITE_URL}"
      from 'michael.carroll@cornell.edu'
      subject 'Re: Set your household mission!'
      raw_html File.read(Rails.root.to_s + '/lib/sample_emails/missions/set_mission_example.eml')
    end
  end

  # factory :inbound_email do
  #   user
  #   to ["my-pushcart-address@#{EMAIL_URI}"]
  #   from 'notices@some_grocery_email.com'
  #   subject 'email subject'
  #   raw_html ''
  #   raw_text ''

  #   trait :fresh_direct_receipt_one do
  #     from 'receipt@freshdirect.com'
  #     subject 'Your order for Sunday, Jan 26 2014'
  #     raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')
  #     raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')
  #   end

  #   trait :fresh_direct_receipt_two do
  #     from 'receipt@freshdirect.com'
  #     subject 'Your order for Sunday, Jan 26 2014'
  #     raw_html File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_two.eml')
  #     raw_text File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_two.eml')
  #   end

  #   trait :instacart_receipt do
  #     from 'orders@instacart.com'
  #     subject 'Fwd: Your Order with Instacart'
  #     raw_html File.read(Rails.root.to_s + '/lib/sample_emails/instacart/instacart_receipt.eml')
  #   end
  # end
end
