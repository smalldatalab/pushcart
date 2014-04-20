FactoryGirl.define do
  factory :email, class: OpenStruct do
    to ["my-pushcart-address@#{EMAIL_URI}"]
    from 'notices@some_grocery_email.com'
    subject 'email subject'
    body 'Hello!'
    attachments {[]}

    trait :fresh_direct_order do
      body 'fresh direct body' #load sample e-mail here
    end
  end
end
