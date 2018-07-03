FactoryBot.define do
  factory :market do
    trait :btccny do
      id            'btccny'
      ask_unit      'btc'
      bid_unit      'cny'
      ask_fee       0.0000
      bid_fee       0.0000
      ask_precision 4
      bid_precision 2
      position      1
      visible       true
    end

    trait :dashpts do
      id            'dashpts'
      ask_unit      'dash'
      bid_unit      'pts'
      ask_fee       0.0000
      bid_fee       0.0000
      ask_precision 4
      bid_precision 4
      position      2
      visible       false
    end
  end
end
