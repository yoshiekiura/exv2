ADMIN_EMAIL = 'admin@peatio.dev'
ADMIN_PASSWORD = 'Pass@word8'

admin_identity = Identity.find_or_create_by(email: ADMIN_EMAIL)
admin_identity.password = admin_identity.password_confirmation = ADMIN_PASSWORD
admin_identity.is_active = true
admin_identity.save!

admin_member = Member.find_or_create_by(email: ADMIN_EMAIL)
admin_member.authentications.build(provider: 'identity', uid: admin_identity.id)
admin_member.save!

if Rails.env == 'development'
  NORMAL_PASSWORD = 'Pass@word8'

  foo = Identity.create(email: 'foo@peatio.dev', password: NORMAL_PASSWORD, password_confirmation: NORMAL_PASSWORD, is_active: true)
  foo_member = Member.create(email: foo.email)
  foo_member.authentications.build(provider: 'identity', uid: foo.id)
  foo_member.tag_list.add 'vip'
  foo_member.tag_list.add 'hero'
  foo_member.save

  bar = Identity.create(email: 'bar@peatio.dev', password: NORMAL_PASSWORD, password_confirmation: NORMAL_PASSWORD, is_active: true)
  bar_member = Member.create(email: bar.email)
  bar_member.authentications.build(provider: 'identity', uid: bar.id)
  bar_member.tag_list.add 'vip'
  bar_member.tag_list.add 'hero'
  bar_member.save
end

Market.create(id: "btccny", ask_unit: "btc", bid_unit: "cny", ask_fee: 0, bid_fee: 0, ask_precision: 4, bid_precision: 2, position: 1, visible: true)
Market.create(id: "ethcny", ask_unit: "eth", bid_unit: "cny", ask_fee: 0, bid_fee: 0, ask_precision: 4, bid_precision: 2, position: 1, visible: true)
Market.create(id: "ethbtc", ask_unit: "eth", bid_unit: "btc", ask_fee: 0, bid_fee: 0, ask_precision: 4, bid_precision: 4, position: 1, visible: true)