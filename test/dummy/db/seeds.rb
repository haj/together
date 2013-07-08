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
  Group.create(
    name: 'Testgroup2',
    user_ids: [user.id]
  )

  Group.create(
    name: 'Join here',
  )

  Group.create(
    name: 'Or join this one',
  )

  Group.create(
    name: 'Or join this one2',
  )

  Group.create(
    name: 'Or join this one3',
  )
end
