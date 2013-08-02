user = User.create(
  email:        'testuser@lab01.nl',
  fullname:     'Testuser',
  password:     'test1234',
  password_confirmation: 'test1234',
  confirmed_at: 1.hour.ago
)

user.with_tenant_scope_schema do
  Group.create(
    name: 'Testgroup',
    user_ids: [user.id]
  )

  10.times do |i|
    Group.create!(
      name: "join me! #{i+2}",
    )
  end
end
